class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :abstract
      t.string :url
      t.integer :edition_id

      t.timestamps
    end
  end
end
