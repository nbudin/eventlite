class CreateSiteSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :site_settings do |t|
      t.text :site_title

      t.timestamps
    end

    reversible do |dir|
      dir.up { SiteSettings.create!(site_title: 'Eventlite') }
    end
  end
end
