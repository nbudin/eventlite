class TicketTypesController < ApplicationController
  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event
  respond_to :html
  layout 'admin'

  def index
  end

  def new
  end

  def create
    if @ticket_type.save
      redirect_to event_ticket_types_path(@event)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @ticket_type.update(ticket_type_params)
      redirect_to event_ticket_types_path(@event)
    else
      render action: 'edit'
    end
  end

  def preview_email_form
  end

  def preview_email
    ticket = @ticket_type.tickets.new(name: 'NAME', email: params[:email], phone: '867-5309', payment_amount: @ticket_type.price)
    TicketChargesMailer.confirmation(ticket).deliver_now

    redirect_to event_ticket_types_url(@event), notice: "Test email sent to #{params[:email]}."
  end

  private

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :number_available, :email_template)
  end
end
