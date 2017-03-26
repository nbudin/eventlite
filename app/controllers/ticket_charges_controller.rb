class TicketChargesController < ApplicationController
  load_resource :event, find_by: 'slug'
  respond_to :json

  def create
    ticket_type = @event.ticket_types.find(params[:ticket][:ticket_type_id])

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

    ticket = ticket_type.tickets.new(ticket_params)
    ticket.assign_attributes(
      payment_amount: ticket_type.price,
      stripe_customer_id: customer.id,
      stripe_charge_id: charge.id
    )

    ticket.save!
    respond_with @event, ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :email, :phone)
  end
end
