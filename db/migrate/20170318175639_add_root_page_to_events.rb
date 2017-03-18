class AddRootPageToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :root_page, foreign_key: { to_table: 'pages' }
  end
end
