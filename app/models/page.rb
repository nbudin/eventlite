class Page < ApplicationRecord
  cadmus_page
  belongs_to :cms_layout

  def to_liquid
    Drops::PageDrop.new(self)
  end
end
