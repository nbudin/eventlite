class Ticket < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :user

  monetize :payment_amount_cents

  scope :canceled, -> { where.not(canceled_at: nil) }
  scope :not_canceled, -> { where(canceled_at: nil) }
end
