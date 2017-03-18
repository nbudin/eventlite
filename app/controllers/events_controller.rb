class EventsController < ApplicationController
  include Cadmus::Renderable
  helper_method :cadmus_renderer

  load_and_authorize_resource find_by: 'slug'
  respond_to :html

  def index
  end

  def new
  end

  def create
    @event.save
    respond_with @event
  end

  def show
  end

  private

  def event_params
    params.require(:event).permit(:name, :slug, :start_time, :end_time, :length_seconds)
  end
end
