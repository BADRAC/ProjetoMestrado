class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]
  
  def index
    @users = User.all
    @edition = Edition.find(params[:edition_id])
    @articles = Article.where(:edition_id => @edition.id).order('id DESC')
  end

  def new  
    @edition = Edition.find(params[:edition_id])
    @article = Article.new
  end

  def edit  
    @edition = Edition.find (params[:edition_id])
    @article = Article.find(params[:id])
  end

  def create
    @edition = Edition.find(params[:edition_id])
    @article = @edition.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to edition_articles_path }

        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_keywords_path(@article.id, @article.edition_id) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @Article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :abstract, :url, :edition_id)
    end
  
end