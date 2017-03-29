class TicketChargesMailer < ApplicationMailer
  def confirmation(ticket)
    @ticket = ticket
    mail(to: ticket.email, subject: "#{ticket.event.name} - #{ticket.ticket_type.name} ticket confirmation")
  end
end
