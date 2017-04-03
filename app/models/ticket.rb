class Ticket < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :user
  has_one :event, through: :ticket_type

  monetize :payment_amount_cents

  scope :canceled, -> { where.not(canceled_at: nil) }
  scope :not_canceled, -> { where(canceled_at: nil) }

  def canceled?
    !!canceled_at
  end

  def to_liquid
    Drops::TicketDrop.new(self)
  end
end
