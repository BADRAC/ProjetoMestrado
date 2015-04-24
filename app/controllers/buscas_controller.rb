class BuscasController < ApplicationController
  def index
  	if params[:search].present?
  		@articles = ArticleSearch.new(query: params[:search]).results
  		#@articles = Article.paginate(page: params[:page], :per_page => 30)
  	else
  		#@articles = Article.paginate(page: params[:page], :per_page => 30)
  		@articles = Article.all
  	end
  end
end
    