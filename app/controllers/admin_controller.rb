class AdminController < ApplicationController
  def index
  end

  def show
    @q = Article.ransack(params[:q])
    @articles = Article.all
    @articles = @q.result(distinct: true)
    @user = current_user
    @users = User.all
  end

  def edit
  end

  def user_destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, status: 303
  end

  def update
  end

  def new
  end

  private

  def secure_params
    params.require(:user).permit(:username, :email, :role)
  end
  
end
