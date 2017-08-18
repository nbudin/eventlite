class CmsFilesController < ApplicationController
  include CadmusFiles::AdminController

  before_action :find_event_and_cms_file
  authorize_resource

  layout 'admin'

  private

  def cms_file_scope
    if @event
      @event.cms_files
    else
      CmsFile.global
    end
  end

  def cms_file_params
    super.merge(uploader: current_user)
  end

  def find_event_and_cms_file
    @event = Event.find_by!(slug: params[:event_id]) if params[:event_id]
    @cms_file = cms_file_scope.find(params[:id]) if params[:id]
  end
end
