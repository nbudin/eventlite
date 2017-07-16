class CmsLayoutsController < ApplicationController
  include Cadmus::LayoutsController

  self.parent_model_class = Event
  self.parent_model_name = 'event'
  self.find_parent_by = 'slug'

  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event

  layout 'admin'

  protected

  def cms_layout_params
    params.require(:cms_layout).permit(:name, :content, :navbar_classes)
  end
end
