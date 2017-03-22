class CmsLayoutsController < ApplicationController
  respond_to :html

  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event

  layout 'admin'

  def index
  end

  def new
  end

  def create
    @cms_layout.save
    respond_with @cms_layout, location: event_cms_layouts_path(@event)
  end

  def edit
  end

  def update
    @cms_layout.update(cms_layout_params)
    respond_with @cms_layout, location: event_cms_layouts_path(@event)
  end

  def destroy
    @cms_layout.destroy
    redirect_to event_cms_layouts_path(@event)
  end

  private

  def cms_layout_params
    params.require(:cms_layout).permit(:name, :content)
  end
end
