class AddEmailSubjectAndEmailFromToTicketTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :ticket_types, :email_subject, :text
    add_column :ticket_types, :email_from, :text

    reversible do |dir|
      dir.up do
        TicketType.update_all(
          email_subject: "{{ ticket.event_name }} - {{ ticket.ticket_type_name }} ticket confirmation",
          email_from: "Occultopus Productions <contact@occultopus.org>"
        )
      end
    end
  end
end
