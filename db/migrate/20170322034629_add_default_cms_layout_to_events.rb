class AddDefaultCmsLayoutToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :default_cms_layout, foreign_key: { to_table: 'cms_layouts' }
  end
end
