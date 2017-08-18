class RootController < ApplicationController
  include Cadmus::Renderable
  helper_method :cadmus_renderer

  layout 'cms_page'

  def index
    @page = Page.root
    @page_title = @page.name
    render template: 'cadmus/pages/show'
  end
end
