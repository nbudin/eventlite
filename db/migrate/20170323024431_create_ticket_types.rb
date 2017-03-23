class CreateTicketTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_types do |t|
      t.references :event, foreign_key: true
      t.text :name
      t.monetize :price
      t.integer :number_available

      t.timestamps
    end
  end
end
