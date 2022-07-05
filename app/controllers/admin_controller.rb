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

  def change_role
    @user = User.find(params[:id])
  end

  def make_admin
    @user = User.find(params[:id])
    @user.role = 'admin'
    redirect_to users_path, status: 303
  end

  def make_user
    @user = User.find(params[:id])
    @user.role = 'user'
    redirect_to users_path, status: 303
  end

  def make_member
    @user = User.find(params[:id])
    @user.role = 'member'
    redirect_to users_path, status: 303
  end

  def update
    @user = User.find(params[:id])
    @user.role = Role.find(params[:role])
    redirect_to users_path
  end

  def new
  end

  private

  def secure_params
    params.require(:user).permit(:username, :email, :role)
  end
  
end
