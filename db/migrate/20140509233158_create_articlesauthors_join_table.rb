class CreateArticlesauthorsJoinTable < ActiveRecord::Migration
  def change
  	create_table :articles_authors, id: false do |t|
      t.belongs_to :article
      t.belongs_to :author
    end
  end
end