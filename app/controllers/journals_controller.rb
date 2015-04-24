class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :new, :edit, :create, 
                                      :update, :destroy]

  # lista os Journal (PERIÓDICOS!!!)
  def index
    @users = User.all
    @journals = Journal.all.order('LOWER(j_name) ASC')
 
    #respond_to do |format|
      #format.html
      #format.csv { send_data @journals.to_csv }
      #format.xls  { send_data @journals.to_csv(col_sep: "\t") }
    #end
  end

  # GET /journals/1
  def show
  end

  # GET /journals/new
  def new
    @journal = Journal.new
  end

  # GET /journals/1/edit
  def edit
  end

  # POST /journals
  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      redirect_to journals_path
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /journals/1
  def update
    if @journal.update(journal_params)
      redirect_to journal_editions_path(@journal.id)
    else
      render action: 'edit'
    end
  end

  # DELETE /journals/1
  def destroy
    Journal.find(params[:id]).destroy
    flash[:success] = "Periódico Removido."
    redirect_to journals_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def journal_params
      params.require(:journal).permit(:j_name)
    end
end
