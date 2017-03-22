class AdminController < ApplicationController
  load_resource :event, find_by: :slug

  layout 'admin'

  def index
    authorize! :manage, @event
  end
end
