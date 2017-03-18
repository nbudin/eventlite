class CreateCmsFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_files do |t|
      t.references :parent, polymorphic: true
      t.references :uploader, foreign_key: { to_table: 'users' }
      t.string :file

      t.timestamps
    end
  end
end
