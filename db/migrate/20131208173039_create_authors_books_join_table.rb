class CreateAuthorsBooksJoinTable < ActiveRecord::Migration
  def change
  	create_table :authors_books, id: false do |t|
      t.belongs_to :book
      t.belongs_to :author
    end
  end
end

