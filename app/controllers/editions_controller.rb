class EditionsController < ApplicationController
before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]

  def index 
    @users = User.all   
    @journal = Journal.find(params[:journal_id])
    @editions = Edition.where(:journal_id => @journal.id).order('e_date DESC, e_name DESC')
  end

  def new  
    @journal = Journal.find(params[:journal_id])
    @edition = Edition.new
  end

  def edit  
    @journal = Journal.find (params[:journal_id])
    @edition = Edition.find(params[:id])
  end

  def create
    @journal = Journal.find(params[:journal_id])
    @edition = @journal.editions.build(edition_params)

    respond_to do |format|
      if @edition.save
        format.html { redirect_to journal_editions_path }
      else
        format.html { render action: 'new' }        
      end
    end
  end

  def update
    @edition = Edition.find(params[:id])

    respond_to do |format|
      if @edition.update(edition_params)
        format.html { redirect_to edition_articles_path(@edition.id) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edition
      @edition = Edition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edition_params
      params.require(:edition).permit(:e_name, :e_date, :journal_id)
    end

end
