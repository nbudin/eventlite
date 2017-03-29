class TicketsController < ApplicationController
  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event
  respond_to :html
  layout 'admin'

  def index
  end
end
