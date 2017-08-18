class Page < ApplicationRecord
  include Cadmus::Page

  cadmus_page
  belongs_to :cms_layout

  def self.root
    global.find_by(slug: 'root')
  end

  def to_liquid
    Drops::PageDrop.new(self)
  end

  def effective_cms_layout
    cms_layout || parent&.default_cms_layout
  end
end
