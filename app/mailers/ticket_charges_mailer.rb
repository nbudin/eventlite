class TicketChargesMailer < ApplicationMailer
  include Cadmus::Renderable
  helper_method :cadmus_renderer

  def confirmation(ticket)
    @ticket = ticket
    @receipt = render_to_string(partial: 'ticket_charges_mailer/receipt', locals: { ticket: @ticket }, format: 'html')

    subject = cadmus_renderer.render(ticket.ticket_type.email_subject_liquid_template, :html)
    mail(from: ticket.ticket_type.email_from, to: ticket.email, subject: subject)
  end

  def liquid_assigns
    { 'ticket' => @ticket, 'receipt' => @receipt }
  end
end
