class AddArticlesAuthorsForeignKey < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE articles_authors 
	  ADD CONSTRAINT fk_articles_authors_articles FOREIGN KEY (article_id) 
	  REFERENCES articles (id)
    ON DELETE CASCADE;

	  ALTER TABLE articles_authors 
	  ADD CONSTRAINT fk_articles_authors_authors FOREIGN KEY (author_id) 
	  REFERENCES authors (id)
    ON DELETE CASCADE;
    SQL
  end
 
  def down
  	ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE articles_authors
      DROP CONSTRAINT fk_articles_authors_articles;

      ALTER TABLE articles_authors
      DROP CONSTRAINT fk_articles_authors_authors;
    SQL
  end
end
