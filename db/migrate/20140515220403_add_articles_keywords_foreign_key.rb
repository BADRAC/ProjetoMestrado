class AddArticlesKeywordsForeignKey < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE articles_keywords 
	    ADD CONSTRAINT fk_articles_keywords_articles FOREIGN KEY (article_id) 
	    REFERENCES articles (id)
      ON DELETE CASCADE;

	    ALTER TABLE articles_keywords 
	    ADD CONSTRAINT fk_articles_keywords_keywords FOREIGN KEY (keyword_id) 
	    REFERENCES keywords (id)
      ON DELETE CASCADE;
    SQL
  end
 
  def down
  	ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE articles_keywords
      DROP CONSTRAINT fk_articles_keywords_articles;

      ALTER TABLE articles_keywords
      DROP CONSTRAINT fk_articles_keywords_keywords;
    SQL
  end

end