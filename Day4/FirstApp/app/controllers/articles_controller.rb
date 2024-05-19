class ArticlesController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def  new
    @article = Article.new
  end

  def create
  @article = Article.new(article_params)
  @article.user = current_user

  if @article.save
    redirect_to @article, notice: 'Article was successfully created.'
  else
    render :new
  end
end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  def report
    @article = Article.find(params[:id])
    if @article
      @article.report
      if @article.report_count >= 3
        @article.status = "archived"
        @article.save
      end

      if @article.report_count >= 6
        @article.destroy
      end
      redirect_to @article
    else
      redirect_to articles_path
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :image)
    end
end
