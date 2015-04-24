class AddArticlesForeignKey < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE articles
      ADD CONSTRAINT fk_articles_editions FOREIGN KEY (edition_id)
      REFERENCES editions(id)
      ON DELETE CASCADE;
    SQL
  end
 
  def down
  	ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE articles
      DROP CONSTRAINT fk_articles_editions
    SQL
  end
end
