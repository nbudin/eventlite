class EventsController < ApplicationController
  include Cadmus::Renderable
  helper_method :cadmus_renderer

  load_and_authorize_resource find_by: 'slug'
  respond_to :html

  layout :determine_layout

  def index
  end

  def show
    @page = @event.root_page
    render template: 'cadmus/pages/show'
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
    @event.update_attributes(event_params)
    respond_with @event, location: event_admin_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :slug, :start_time, :end_time, :length_seconds, :default_cms_layout_id)
  end

  def determine_layout
    case params[:action]
    when 'edit' then 'admin'
    when 'show' then 'cms_page'
    else 'application'
    end
  end
end
