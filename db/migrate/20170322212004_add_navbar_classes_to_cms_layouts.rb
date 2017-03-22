class AddNavbarClassesToCmsLayouts < ActiveRecord::Migration[5.1]
  def change
    add_column :cms_layouts, :navbar_classes, :text
  end
end
