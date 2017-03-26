class Ticket < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :user

  scope :canceled, -> { where.not(canceled_at: nil) }
  scope :not_canceled, -> { where(canceled_at: nil) }
end
