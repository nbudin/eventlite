class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.text :name
      t.datetime :start_time
      t.integer :length_seconds

      t.timestamps
    end
  end
end
