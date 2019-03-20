class PublicationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  def index
    @publications = Publication.all
    #authorize @articles
    #set_meta_tags title: 'Articles'
  end

  def show
  end

  # GET /articles/new
  def new
    @publication = current_user.publications.new
    #authorize @article
    #set_meta_tags title: 'New Article'
  end

  # GET /articles/1/edit
  def edit
    #set_meta_tags title: "Edit #{@article.title}"
  end

  # POST /articles
  def create
    @publication = current_user.publications.new(publication_params)
    #authorize @article

    if @publication.save
      redirect_to @publication, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
      if @publication.update(publication_params)
        redirect_to @publication, notice: 'Article was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @publication.destroy
    redirect_to publications_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:title, :description)
    end
end
