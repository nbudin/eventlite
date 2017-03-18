class AddSlugToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :slug, :string, null: false
    add_index :events, :slug, unique: true
  end
end
