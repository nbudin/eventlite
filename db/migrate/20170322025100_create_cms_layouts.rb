class CreateCmsLayouts < ActiveRecord::Migration[5.1]
  def change
    create_table :cms_layouts do |t|
      t.references :parent, polymorphic: true
      t.text :name
      t.text :content

      t.timestamps
    end
  end
end
