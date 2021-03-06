class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]
  after_action :verify_authorized, except: :index


  def index
    @articles = Article.all.page(params[:page])
    authorize @articles
    set_meta_tags title: 'Articles'
  end

  def show
    impressionist(@article)
    set_meta_tags @article
  end

  # GET /articles/new
  def new
    @article = current_user.articles.new
    authorize @article
    set_meta_tags title: 'New Article'
  end

  # GET /articles/1/edit
  def edit
    set_meta_tags title: "Edit #{@article.title}"
  end

  # POST /articles
  def create
    @article = current_user.articles.new(article_params)
    authorize @article

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  def like
    if current_user.voted_for? @article
      @article.unliked_by current_user
    else
      @article.liked_by current_user
    end
    redirect_to @article
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
      if @article.hash_id != params[:id]
        redirect_to action: :show, id: @article.hash_id, status: 301
      end

      authorize @article
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
