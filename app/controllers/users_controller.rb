class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  include Pundit

  def index
    authorize User
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :ASC)
  end

  def search
    @users =  User.where("email_or_user_name LIKE ?", "%" + params[:q] + "%").paginate(page: params[:page], per_page: 10)
  end

  def show
    @users=User.order(created_at: :desc)
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 3) 
  end
  
  def pundit_user
    User.find(current_user.id)
  end
  
  private

  def set_user
    @user=User.find(params[:id])
  end

  def get_users
  end

  def secure_params
    params.require(:user).permit(:role, :username, :email)
  end
end


