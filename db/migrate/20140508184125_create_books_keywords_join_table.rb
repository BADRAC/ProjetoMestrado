class CreateBooksKeywordsJoinTable < ActiveRecord::Migration
  def change
  	create_table :books_keywords, id: false do |t|
      t.belongs_to :book
      t.belongs_to :keyword
    end
  end
end

