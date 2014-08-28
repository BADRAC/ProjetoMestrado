class BooksController < ActionController::Base
  before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]
  def index
      @edition = Edition.find(params[:edition_id])
      @books = Book.where(:edition_id => @edition.id) 
  end

  def new  
    @edition = Edition.find(params[:edition_id])
    @book = Book.new
  end

  def create
    @edition = Edition.find(params[:edition_id])
    @book = @edition.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to edition_books_path, notice: 'O artigo foi criado com sucesso.' }

        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :abstract, :url, :num_pages, :edition_id)
    end
  
end