class NavigationItem < ApplicationRecord
  belongs_to :parent, class_name: 'NavigationItem', inverse_of: :children
  belongs_to :page
  belongs_to :event
  has_many :children, class_name: 'NavigationItem', foreign_key: 'parent_id', inverse_of: :parent, dependent: :destroy

  scope :root, -> { where(parent_id: nil) }

  acts_as_list scope: [:event_id, :parent_id]

  def item_type
    if page || parent
      'link'
    else
      'section'
    end
  end
end
