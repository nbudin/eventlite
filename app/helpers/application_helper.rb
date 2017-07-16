module ApplicationHelper
  def liquid_assigns_for_layout(cms_layout)
    head_content = render(partial: 'layouts/head')
    {
      'content_for_head' => head_content,
      'content_for_navbar' => navigation_bar(cms_layout.navbar_classes)
    }
  end

  def navigation_bar(navbar_classes = nil)
    navbar_classes ||= 'navbar-light bg-faded'

    if @event
      renderer = CadmusNavbar::Renderers::Bootstrap4.from_parent(
        parent: @event,
        request: request,
        url_for_page: ->(page) { canonical_page_path(page) }
      )
      render partial: 'layouts/cms_navigation_bar', locals: { renderer: renderer, navbar_classes: navbar_classes }
    else
      render partial: 'layouts/non_cms_navigation_bar', locals: { navbar_classes: navbar_classes }
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

  def admin_nav_link_to(title, path)
    classes = ['nav-link']
    classes << 'active' if request.path.start_with?(path)

    link_to title, path, class: classes.join(' ')
  end

  def canonical_page_path(page)
    if page == page.parent.root_page
      polymorphic_url(page.parent, routing_type: :path)
    else
      polymorphic_url([page.parent, page], routing_type: :path)
    end
  end
end
