class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:q]
      @articles = Article.search(columns: [:title, :description], keywords: params[:q])
      return
    end

    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])

    @article
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params.merge(user_id: current_user.id))

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])

    fail ActiveRecord::RecordNotFound unless current_user.has?(@article)

    @article
  end

  def update
    @article = Article.find(params[:id])

    fail ActiveRecord::RecordNotFound unless current_user.has?(@article)

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])

    fail ActiveRecord::RecordNotFound unless current_user.has?(@article)

    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
