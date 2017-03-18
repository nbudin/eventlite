module ApplicationHelper
  def navigation_bar
    if @cms_page
      navigation_presenter = CmsSiteNavigationPresenter.new(@cms_page.site, @cms_page)
      render partial: 'layouts/cms_navigation_bar', locals: { cms_site: @cms_page.site, navigation_presenter: navigation_presenter }
    else
      render partial: 'layouts/non_cms_navigation_bar'
    end
  end

  def render_navigation_item(item)
    case item
    when CmsSiteNavigationPresenter::NavigationLink then render_navigation_link(item)
    when CmsSiteNavigationPresenter::NavigationSection then render_navigation_section(item)
    end
  end

  def render_navigation_section(section)
    content_tag(:li, class: 'dropdown') do
      safe_join([
        content_tag(:a, class: "dropdown-toggle", "data-toggle" => "dropdown", role: "button", "aria-haspopup" => "true", "aria-expanded" => "false") do
          safe_join([
            section.cms_page.label,
            ' ',
            content_tag(:span, '', class: 'caret')
          ])
        end,
        content_tag(:ul, class: 'dropdown-menu') do
          safe_join(section.items.map { |item| render_navigation_link(item) })
        end
      ])
    end
  end

  def render_navigation_link(item)
    content_tag(:li, class: (item.is_active ? 'active' : '')) do
      link_to item.cms_page.url(:relative) do
        safe_join(
          [
            item.cms_page.label,
            (item.is_active ? content_tag(:span, ' (current)', class: 'sr-only') : nil)
          ].compact
        )
      end
    end
  end
end
