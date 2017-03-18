class AdminController < ApplicationController
  load_resource :event, find_by: :slug

  def index
    authorize! :manage, @event
  end
end
