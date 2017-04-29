class CmsFilesController < ApplicationController
  include CadmusFiles::AdminController

  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event

  layout 'admin'

  private

  def cms_file_scope
    @event.cms_files
  end

  def cms_file_params
    super.merge(uploader: current_user)
  end
end
