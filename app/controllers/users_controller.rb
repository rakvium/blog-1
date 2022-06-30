class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  before_action :get_users, only: [:index, :show]
  before_action :authenticate_user!
  include Pundit
  

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 3) 
  end

  def pundit_user
    User.find(current_user.id)
  end
  
  def index
    @users = User.all
    authorize User
  end

  private

  def set_user
    @user=User.find(params[:id])
  end

  def get_users
    @users=User.order(created_at: :desc)
  end

  def secure_params
    params.require(:user).permit(:role)
  end
end


