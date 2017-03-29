class TicketChargesController < ApplicationController
  load_resource :event, find_by: 'slug'
  respond_to :json

  def create
    ticket_type = @event.ticket_types.find(params[:ticket][:ticket_type_id])
    ticket = nil

    begin
      ActiveRecord::Base.with_advisory_lock("ticket_type_#{ticket_type.id}") do
        if ticket_type.tickets.count >= ticket_type.number_available
          return render plain: "Sorry, but #{ticket_type.name} tickets are sold out.", status: :not_acceptable
        end

        customer, charge = charge_on_stripe(ticket_type)

        ticket = ticket_type.tickets.new(ticket_params)
        ticket.assign_attributes(
          payment_amount: ticket_type.price,
          stripe_customer_id: customer.id,
          stripe_charge_id: charge.id
        )

        ticket.save!
      end
    rescue Exception => e
      return render plain: e.message, status: 500
    end

    TicketChargesMailer.confirmation(ticket).deliver_now
    respond_with @event, ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :email, :phone)
  end

  def charge_on_stripe(ticket_type)
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => ticket_type.price.fractional,
      :description => "#{ticket_type.name} for #{@event.name}",
      :currency    => ticket_type.price.currency
    )

    return [customer, charge]
  end
end
