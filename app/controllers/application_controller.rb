class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |error|
    Rails.logger.warn(error.message)

    if user_signed_in?
      redirect_to root_url, :alert => error.message
    else
      session[:user_return_to] = request.url
      redirect_to new_user_session_url, :alert => "Please log in to view this page."
    end
  end

  protected

  def site_settings
    @site_settings ||= SiteSettings.instance
  end
  helper_method :site_settings

  def liquid_assigns
    common_assigns = {
      'page_title' => page_title,
      'site_title' => site_settings.site_title,
      'current_user' => current_user
    }

    if @event
      common_assigns.merge('event' => @event)
    else
      common_assigns.merge('events' => Event.all.map(&:to_liquid))
    end
  end

  def liquid_registers
    { 'parent' => @event, 'controller' => self }
  end

  def page_title
    [@page_title, @event&.name || site_settings.site_title].compact.join(' - ')
  end
  helper_method :page_title
end
