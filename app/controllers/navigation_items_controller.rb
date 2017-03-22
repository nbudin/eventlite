class NavigationItemsController < ApplicationController
  respond_to :html

  load_resource :event, find_by: 'slug'
  load_and_authorize_resource through: :event

  layout 'admin'

  def index
  end

  def create
    @navigation_item.save
    respond_with @navigation_item, location: edit_event_navigation_item_path(@event, @navigation_item)
  end

  def destroy
    @navigation_item.destroy
    if @navigation_item.parent
      redirect_to edit_event_navigation_item_path(@event, @navigation_item.parent)
    else
      redirect_to event_navigation_items_path(@event)
    end
  end

  def update
    @navigation_item.update(navigation_item_params)
    respond_with @navigation_item, location: edit_event_navigation_item_path(@event, @navigation_item)
  end

  def sort
    ids = params[:navigation_item_ids].map(&:to_i)
    navigation_items = @event.navigation_items.find(ids)

    navigation_items.each do |item|
      item.update_column(:position, ids.index(item.id) + 1)
    end
  end

  private

  def navigation_item_params
    params.require(:navigation_item).permit(:parent_id, :title, :page_id)
  end
end
