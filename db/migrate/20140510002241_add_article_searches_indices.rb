class AddArticleSearchesIndices < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE INDEX index_articles_on_title ON articles USING gin(to_tsvector('english', title));
      CREATE INDEX index_articles_on_abstract ON articles USING gin(to_tsvector('english', abstract));
    SQL
  end

  def down
    ActiveRecord::Base.connection.execute <<-SQL
      DROP INDEX index_articles_on_title;
      DROP INDEX index_articles_on_abstract;
    SQL
  end

end
