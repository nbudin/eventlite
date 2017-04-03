class AddEmailTemplateToTicketTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :ticket_types, :email_template, :text

    reversible do |dir|
      dir.up do
        default_template = <<-HTML
<h1>Purchase Confirmation</h1>

<p>
  Thanks for your ticket purchase!  You've bought a {{ ticket.ticket_type_name }} ticket for {{ ticket.event_name }}.
</p>

{{ receipt }}
HTML

        TicketType.update_all(email_template: default_template)
      end
    end
  end
end
