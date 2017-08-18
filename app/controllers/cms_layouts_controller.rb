class CmsLayoutsController < ApplicationController
  include Cadmus::LayoutsController

  self.parent_model_class = Event
  self.parent_model_name = 'event'
  self.find_parent_by = 'slug'

  before_action :find_event_and_cms_layout
  authorize_resource

  layout 'admin'

  protected

  def cms_layout_params
    params.require(:cms_layout).permit(:name, :content, :navbar_classes)
  end

  def find_event_and_cms_layout
    if params[:event_id]
      @event = Event.find_by!(slug: params[:event_id])
    end

    if params[:id]
      if @event
        @cms_layout = @event.cms_layouts.find(params[:id])
      else
        @cms_layout = CmsLayout.global.find(params[:id])
      end
    end
  end
end
