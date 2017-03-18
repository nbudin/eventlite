class EventsController < ApplicationController
  include Cadmus::Renderable
  helper_method :cadmus_renderer

  load_and_authorize_resource find_by: 'slug'
  respond_to :html

  layout 'admin', only: [:edit]

  def index
  end

  def show
  end

  def new
  end

  def create
    @event.save
    respond_with @event
  end

  def edit
  end

  def update
    @event.save
    respond_with @event, location: event_admin_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :slug, :start_time, :end_time, :length_seconds)
  end
end
