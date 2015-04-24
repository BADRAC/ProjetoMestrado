class AddEditionsForeignKey < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE editions
      ADD CONSTRAINT fk_editions_journals FOREIGN KEY (journal_id)
      REFERENCES journals(id)
      ON DELETE CASCADE;
    SQL
  end
 
  def down
  	ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE editions
      DROP CONSTRAINT fk_editions_journals
    SQL
  end
end