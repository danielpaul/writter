class PublicationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :add_to_publications_users, only: [:create]

  def index
    @publications = Publication.all
    authorize @publications
    set_meta_tags title: 'All Publications'
  end

  def show
    authorize @publication
  end

  # GET /publications/new
  def new
    @publication = current_user.publications.new
    authorize @publication
    set_meta_tags title: 'New Publication'
  end

  # GET /publications/1/edit
  def edit
    authorize @publication
    #set_meta_tags title: "Edit #{@article.title}"
  end

  # POST /publications
  def create
    @publication = current_user.publications.new(publication_params)
    authorize @publication

    if @publication.save
      redirect_to @publication, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @publication
    if @publication.update(publication_params)
      redirect_to @publication, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @publication
    @publication.destroy
    redirect_to publications_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def add_to_publications_users
      @publication.users << current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:title, :description)
    end
end
