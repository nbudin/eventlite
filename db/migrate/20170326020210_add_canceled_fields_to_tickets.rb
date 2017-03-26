class AddCanceledFieldsToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :canceled_at, :timestamp
    add_column :tickets, :cancellation_notes, :text
  end
end
