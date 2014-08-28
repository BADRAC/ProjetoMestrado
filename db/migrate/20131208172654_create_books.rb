class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :abstract
      t.string :url
      t.integer :num_pages
      t.integer :edition_id

      t.timestamps
    end
  end
end
