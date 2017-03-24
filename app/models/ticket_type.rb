class TicketType < ApplicationRecord
  belongs_to :event
  has_many :tickets

  monetize :price_cents
end
