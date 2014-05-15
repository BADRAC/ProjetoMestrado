class CreateEditions < ActiveRecord::Migration
  def change
    create_table :editions do |t|
      t.string :e_name
      t.date :e_date
      t.integer :journal_id

      t.timestamps
    end
  end
end
