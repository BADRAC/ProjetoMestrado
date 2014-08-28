class AddCodmergToTables < ActiveRecord::Migration
def up
    ActiveRecord::Base.connection.execute <<-SQL
		ALTER TABLE journals ADD COLUMN cod_merg varchar(80);
		ALTER TABLE editions ADD COLUMN cod_merg varchar(80);
		ALTER TABLE articles ADD COLUMN cod_merg varchar(80);
		ALTER TABLE keywords ADD COLUMN cod_merg varchar(80);
		ALTER TABLE authors ADD COLUMN cod_merg varchar(80);
    SQL
  end
 
  def down
  	ActiveRecord::Base.connection.execute <<-SQL
		ALTER TABLE journals ADD COLUMN cod_merg RESTRICT;
		ALTER TABLE editions ADD COLUMN cod_merg RESTRICT;
		ALTER TABLE articles ADD COLUMN cod_merg RESTRICT;
		ALTER TABLE keywords ADD COLUMN cod_merg RESTRICT;
		ALTER TABLE authors ADD COLUMN cod_merg RESTRICT;      
    SQL
  end

end

