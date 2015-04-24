class AddAdminUser < ActiveRecord::Migration
   def up
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO users(
            id, name, email, password_digest, admin)
      VALUES (1, 'Admin', 'admin@admin.com', 
      		'$2a$10$gILy98QA.uTOHM3TbI7v1OnTBS6qkZGPvXZB2rSO/8r6KCSOjj3hy', 
      		true)
    SQL
  end
 
  def down
  	ActiveRecord::Base.connection.execute <<-SQL
      DELETE FROM users
 	  WHERE id = 1
    SQL
  end
end
