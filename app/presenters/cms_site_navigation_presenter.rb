class CmsSiteNavigationPresenter
  class NavigationSection
    attr_reader :cms_page, :items

    def initialize(cms_page, items)
      @cms_page = cms_page
      @items = items
    end
  end

  class NavigationLink
    attr_reader :cms_page, :is_active

    def initialize(cms_page, is_active)
      @cms_page = cms_page
      @is_active = is_active
    end
  end

  attr_reader :cms_site, :current_page

  def initialize(cms_site, current_page)
    @cms_site = cms_site
    @current_page = current_page
  end

  def navigation_items
    cms_site.pages.root.children.published.map do |child|
      children = child.children.to_a.select(&:is_published?).sort_by(&:position)

      if children.any?(&:is_published?)
        grandchild_items = children.map do |grandchild|
          navigation_link(grandchild)
        end

        items = [navigation_link(child), *grandchild_items]
        NavigationSection.new(child, items)
      else
        navigation_link(child)
      end
    end
  end

  private

  def navigation_link(cms_page)
    NavigationLink.new(cms_page, cms_page == current_page)
  end
end