class UsersController < ApplicationController
  before_action :set_user

  def show
    @user = User.find(params[:id])
    @pagy, @articles = pagy(@user.articles)

  end
  
  def index
    @articles = @user.articles.paginate(page: params[:page], per_page: 2) 
  end

  private

  def set_user
    @user=User.find(params[:id])
  end
end
