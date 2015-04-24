class KeywordsController < ApplicationController
  autocomplete :keyword, :kw_name, :full => true

  before_action :set_keyword, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]

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
              "SELECT id, fullname
              FROM    authors,
                      articles_authors
              WHERE   authors.id = articles_authors.author_id
                      AND articles_authors.article_id = :id", {:id => params[:article_id]}])
  end

  def show
  end

  def new
    @article = Article.find (params[:article_id])
    @keyword = Keyword.new
  end

  def edit
    @article = Article.find (params[:article_id])
    @keyword = Keyword.find(params[:id])
  end

  def create
      #Funciona perfeito. Mas insere repetidos.
      #@keyword = Keyword.new(keyword_params)
      #@article = Article.find (params[:article_id])
      #@keyword.articles << @article
      #FIM

      #Só insere em autores se não existir.
      #mas insere na junction table.
      @article = Article.find (params[:article_id])
      @keyword = Keyword.where(keyword_params).first_or_create  
      @keyword.articles << @article
    
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

  # DELETE HABTM
  def destroy
      article = Article.find(params[:article_id])
      keyword = article.keywords.find(params[:id])
     if keyword
        article.keywords.delete(keyword)
     end

     flash[:success] = "Palavra-chave Removida com sucesso."
     redirect_to article_keywords_path(article.id, article.edition_id)

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
