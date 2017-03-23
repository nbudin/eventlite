class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :ticket_type, foreign_key: true
      t.references :user, foreign_key: true
      t.monetize :payment_amount
      t.text :name
      t.text :email
      t.text :phone
      t.text :stripe_customer_id
      t.text :stripe_charge_id

      t.timestamps
    end
  end
end
