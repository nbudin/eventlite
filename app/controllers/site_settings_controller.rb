class SiteSettingsController < ApplicationController
  before_action :find_site_settings
  authorize_resource :site_settings

  layout 'admin'

  def show
  end

  def update
    @site_settings.update(site_settings_params)
    redirect_to admin_url
  end

  private

  def find_site_settings
    @site_settings = SiteSettings.instance
  end

  def site_settings_params
    params.require(:site_settings).permit(:site_title)
  end
end
