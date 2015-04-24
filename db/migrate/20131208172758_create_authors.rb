class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :fullname     
      
      t.timestamps
    end
  end
end
