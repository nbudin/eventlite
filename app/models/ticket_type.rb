class TicketType < ApplicationRecord
  belongs_to :event
  has_many :tickets

  monetize :price_cents

  def available?
    tickets.count < number_available
  end

  def email_liquid_template
    Liquid::Template.parse(email_template)
  end
end
