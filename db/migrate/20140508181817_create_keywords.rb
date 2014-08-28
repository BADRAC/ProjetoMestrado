class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :kw_name

      t.timestamps
    end
  end
end
