class CmsFilesController < ApplicationController
  respond_to :html

  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event

  layout 'admin'

  def index
  end

  def create
    @cms_file.uploader = current_user
    @cms_file.save!

    respond_with @cms_file, location: event_cms_files_path(@event)
  end

  def destroy
    @cms_file.destroy
    redirect_to event_cms_files_path(@event)
  end

  private

  def cms_file_params
    params.require(:cms_file).permit(:file)
  end
end
