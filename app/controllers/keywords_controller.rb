class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]
  # GET /keywords
  #def index
    #@keywords = Keyword.all
  #end

  def index
    #Quando faço - @edicao = Edicao.find (params[:edicao_id]) - nao tem id de edicao
    # entao coloquei um parametro a mais no link_to do INDEX de artigo (@edicao)
    # Fica como se fosse um paramentro em "format" 
    #<td><%= link_to 'INDEX', artigo_palavrachaves_path(artigo.id, @edicao.id) %></td>
    # url = palavrachave.format???????????
    # deu certo.
    
    @edition = Edition.find (params[:format])
    @article = Article.find (params[:article_id])
    @keywords =  Keyword.find_by_sql([
              "SELECT id, kw_name
              FROM    keywords,
                      articles_keywords
              WHERE   keywords.id = articles_keywords.keyword_id
                      AND articles_keywords.article_id = :id", {:id => params[:article_id]}])  
              
    @opas =  Keyword.find_by_sql([
              "SELECT id, first_name, last_name 
              FROM    authors,
                      articles_authors
              WHERE   authors.id = articles_authors.author_id
                      AND articles_authors.article_id = :id", {:id => params[:article_id]}])
  
  end

  # GET /keywords/1
  def show
  end

  # GET /keywords/new
  def new
    @article = Article.find (params[:article_id])
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
    @article = Article.find (params[:article_id])
    @keyword = Keyword.find(params[:id])
  end

  # POST /keywords
  def create
    #Se a palavra que tentar ser criada já existir,
    #entra nesse array.
    # status = OK!
    #@existe =  Keyword.find_by_sql([
               # "SELECT kw_name
                #FROM    keywords
                #WHERE   keywords.kw_name = :keyword_name", 
                #{:keyword_name => params[:keyword][:kw_name]}])

    #Se NÃO existir palavra no array - cria palavra e a relacao na join table
    # status = OK!
    #if @existe.empty?
      @keyword = Keyword.new(keyword_params)
      @article = Article.find (params[:article_id])
      @keyword.articles << @article
    #Se existir palavra no array - cria APENAS a relacao na join table
    # status = FUDEU!
    #else
    #  @article = Article.find (params[:article_id])
      #@keyword.articles << @article
    #end
    
    respond_to do |format|
      if @keyword.save
        format.html { redirect_to article_keywords_path(@article.id, @article.edition_id) }

        format.json { render action: 'show', status: :created, location: @keyword }
      else
        format.html { render action: 'new' }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @article = Article.find (params[:article_id])
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to article_keywords_path(@article.id, @article.edition_id) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    redirect_to keywords_url, notice: 'Keyword was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def keyword_params
      params.require(:keyword).permit(:kw_name)
    end
end
