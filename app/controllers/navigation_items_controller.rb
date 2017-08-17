class NavigationItemsController < ApplicationController
  load_resource :event, find_by: 'slug'

  include CadmusNavbar::AdminController
  load_and_authorize_resource through: :event

  layout 'admin'

  private

  def navigation_item_scope
    @event.navigation_items
  end
end
