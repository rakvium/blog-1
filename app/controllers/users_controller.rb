class UsersController < ApplicationController
  before_action :set_user

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 3) 
  end
  
  def index

  end

  private

  def set_user
    @user=User.find(params[:id])
  end
end
