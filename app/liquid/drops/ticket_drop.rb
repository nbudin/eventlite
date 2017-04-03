class Drops::TicketDrop < Liquid::Drop
  attr_reader :ticket
  delegate :name, :email, :phone, :event, :ticket_type, to: :ticket
  delegate :name, to: :ticket_type, prefix: true
  delegate :name, to: :event, prefix: true

  def initialize(ticket)
    @ticket = ticket
  end
end