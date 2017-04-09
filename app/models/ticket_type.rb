class TicketType < ApplicationRecord
  belongs_to :event
  has_many :tickets

  monetize :price_cents
  liquid_template_field :email_subject_liquid_template, :email_subject
  liquid_template_field :email_liquid_template, :email_template

  def available?
    tickets.count < number_available
  end
end
