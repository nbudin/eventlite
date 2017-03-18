class NavigationItem < ApplicationRecord
  belongs_to :parent
  belongs_to :page
  belongs_to :event
  has_many :children, class_name: 'NavigationItem', foreign_key: 'parent_id'

  scope :root, -> { where(parent_id: nil) }

  acts_as_list scope: [:event_id, :parent_id]
end
