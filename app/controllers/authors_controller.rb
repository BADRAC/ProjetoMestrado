class AuthorsController < ApplicationController
autocomplete :author, :fullname, :full => true

before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]
before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    #Quando faço - @edicao = Edicao.find (params[:edicao_id]) - nao tem id de edicao
    # entao coloquei um parametro a mais no link_to do INDEX de artigo (@edicao)
    # Fica como se fosse um paramentro em "format" 
    #<td><%= link_to 'INDEX', artigo_palavrachaves_path(artigo.id, @edicao.id) %></td>
    # url = palavrachave.farmat???????????
    # deu certo.
    @edition = Edition.find (params[:format])
    @article = Article.find (params[:article_id])
    @authors =  Author.find_by_sql(["SELECT  * 
                                                FROM    authors,
                                                        articles_authors
                                                WHERE   authors.id = articles_authors.author_id
                                                        AND articles_authors.article_id = :id", {:id => params[:article_id]}])
                                                        #AND artigos_palavrachaves.artigo_id = artigo_id") 
  end

  def show
  end

  def new
    @article = Article.find (params[:article_id])
    @author = Author.new
  end

  def edit
    @article = Article.find (params[:article_id])
    @author = Author.find(params[:id])
  end

  def create
    
      #Funciona perfeito. Mas insere repetidos.
      #@author = Author.new(author_params)
      #@article = Article.find (params[:article_id])
      #@author.articles << @article
      #FIM

      #Só insere em autores se não existir.
      #mas insere na junction table.
      @article = Article.find (params[:article_id])
      @author = Author.where(author_params).first_or_create  
      @author.articles << @article

    respond_to do |format|
      if @author.save
        format.html { redirect_to article_keywords_path(@article.id, @article.edition_id) }

        format.json { render action: 'show', status: :created, location: @author }
      else
        format.html { render action: 'new' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @article = Article.find (params[:article_id])
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to article_keywords_path(@article.id, @article.edition_id) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE HABTM
  def destroy
    article = Article.find(params[:article_id])
    author = article.authors.find(params[:id])
     if author
        article.authors.delete(author)
     end

     flash[:success] = "Autor Removido com Sucesso."
     redirect_to article_keywords_path(article.id, article.edition_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def author_params
      params.require(:author).permit(:fullname)
    end
end
