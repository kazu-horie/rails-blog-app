class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new

    @users = User.all
  end

  def create
    @user = User.find_by(name: user_param[:user_name])

    @article = Article.new(article_params.merge(user_id: @user.id))

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])

    @users = User.all
  end

  def update
    @user = User.find_by(name: user_param[:user_name])

    @article = Article.find(params[:id])

    if @article.update(article_params.merge(user_id: @user.id))
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def user_param
    params.require(:article).permit(:user_name)
  end
end
