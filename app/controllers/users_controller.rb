class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def login
    @user = User.find_by(name: params[:user_name])

    if @user.nil? || !@user.authenticate(params[:password])
      flash[:error] = 'Failed login'
      redirect_to root_path
      return
    end

    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
