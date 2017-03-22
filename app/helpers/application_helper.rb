module ApplicationHelper
  def navigation_bar
    if @event
      navigation_items = @event.navigation_items.root.includes(:page, children: :page).order(:position)
      render partial: 'layouts/cms_navigation_bar', locals: { navigation_items: navigation_items }
    else
      render partial: 'layouts/non_cms_navigation_bar'
    end
  end

  def render_navigation_item(item)
    case item.item_type
    when 'section' then render_navigation_section(item)
    when 'link' then render_navigation_link(item, 'nav-item nav-link')
    end
  end

  def render_navigation_section(section)
    content_tag(:li, class: 'nav-item dropdown') do
      safe_join([
        content_tag(:a, section.title, class: "nav-link dropdown-toggle", "data-toggle" => "dropdown", role: "button", "aria-haspopup" => "true", "aria-expanded" => "false"),
        content_tag(:div, class: 'dropdown-menu') do
          safe_join(section.children.sort_by(&:position).map { |item| render_navigation_link(item, 'dropdown-item') })
        end
      ])
    end
  end

  def render_navigation_link(item, item_class)
    is_active = navigation_item_is_active?(item)

    classes = [item_class]
    classes << 'active' if is_active

    link_to event_page_path(@event, item.page), class: classes.join(' ') do
      safe_join(
        [
          item.title,
          (is_active ? content_tag(:span, ' (current)', class: 'sr-only') : nil)
        ].compact
      )
    end
  end

  def navigation_item_is_active?(item)
    params[:controller] == 'pages' && params[:action] == 'show' && @page == item.page
  end
end
