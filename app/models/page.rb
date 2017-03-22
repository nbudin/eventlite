class Page < ApplicationRecord
  cadmus_page
  belongs_to :cms_layout

  def to_liquid
    Drops::PageDrop.new(self)
  end

  def effective_cms_layout
    cms_layout || parent.default_cms_layout
  end
end
