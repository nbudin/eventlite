class CreateNavigationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :navigation_items do |t|
      t.text :title
      t.references :event, foreign_key: true
      t.references :parent, foreign_key: { to_table: 'navigation_items' }
      t.references :page, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
