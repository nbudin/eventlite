class CmsLayout < ApplicationRecord
  include Cadmus::LiquidTemplateField

  belongs_to :parent, polymorphic: true
  validates_uniqueness_of :name, scope: [:parent_id, :parent_type]
  liquid_template_field :liquid_template, :content
end
