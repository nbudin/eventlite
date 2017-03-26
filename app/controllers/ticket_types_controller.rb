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

  private

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :number_available)
  end
end
