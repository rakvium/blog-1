class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  before_action :get_users, only: [:index, :show]
  include Pundit
  

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 3) 
  end
  
  def pundit_user
    User.find(current_user.id)
  end
  
  def index
    @q = User.ransack(params[:q])
    @users = User.all
    @users = @q.result(distinct: true)
    authorize User
  end

  def search
    @users =  User.where("username_or_email_or_role LIKE ?", "%" + params[:q] + "%").paginate(page: params[:page], per_page: 10)
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


