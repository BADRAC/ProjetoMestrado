class BuscasController < ApplicationController
  def index
  	if params[:search].present?
  		@articles = ArticleSearch.new(query: params[:search]).results
  	else
  		@articles = Article.all
  	end
  end
end
    
