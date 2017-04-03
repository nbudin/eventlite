class TicketChargesMailer < ApplicationMailer
  include Cadmus::Renderable
  helper_method :cadmus_renderer

  def confirmation(ticket)
    @ticket = ticket
    @receipt = render_to_string(partial: 'ticket_charges_mailer/receipt', locals: { ticket: @ticket }, format: 'html')
    mail(to: ticket.email, subject: "#{ticket.event.name} - #{ticket.ticket_type.name} ticket confirmation")
  end
end
