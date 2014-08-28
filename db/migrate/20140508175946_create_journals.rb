class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :j_name

      t.timestamps
    end
  end
end
