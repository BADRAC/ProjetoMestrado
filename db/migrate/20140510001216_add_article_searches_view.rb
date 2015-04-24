class AddArticleSearchesView < ActiveRecord::Migration
  def up
  	ActiveRecord::Base.connection.execute <<-SQL
  		CREATE OR REPLACE VIEW article_searches AS

			SELECT articles.id AS searchable_id, 
			'Article' AS searchable_type, 
			articles.title AS term
			FROM articles

			UNION 

			SELECT articles.id AS searchable_id, 
			'Article' AS searchable_type, 
			articles.abstract AS term
			FROM articles

			UNION 

			SELECT articles.id AS searchable_id, 
			'Article' AS searchable_type, 
			authors.fullname AS term
			FROM articles_authors
			JOIN authors ON articles_authors.author_id = authors.id
			JOIN articles ON articles_authors.article_id = articles.id

			UNION

			SELECT articles.id AS searchable_id,
			'Article' AS searchable_type,
			keywords.kw_name AS term
			FROM articles_keywords
			JOIN keywords ON articles_keywords.keyword_id = keywords.id
			JOIN articles ON articles_keywords.article_id = articles.id


	SQL
  end

def down
	ActiveRecord::Base.connection.execute <<-SQL
  	DROP VIEW article_searches;
  	SQL
end
end
