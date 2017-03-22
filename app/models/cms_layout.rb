class CmsLayout < ApplicationRecord
  belongs_to :parent, polymorphic: true
  validates_uniqueness_of :name, scope: [:parent_id, :parent_type]

  def liquid_template
    Liquid::Template.parse(content)
  end
end
