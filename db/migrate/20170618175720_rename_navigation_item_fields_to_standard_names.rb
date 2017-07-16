class RenameNavigationItemFieldsToStandardNames < ActiveRecord::Migration[5.1]
  def change
    change_table :navigation_items do |t|
      t.rename :parent_id, :navigation_section_id
      t.rename :event_id, :parent_id
      t.string :parent_type
    end

    reversible do |dir|
      dir.up { execute "UPDATE navigation_items SET parent_type = 'Event'" }
    end
  end
end
