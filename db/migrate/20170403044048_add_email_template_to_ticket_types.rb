class AddEmailTemplateToTicketTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :ticket_types, :email_template, :text
  end
end
