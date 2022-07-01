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

  def update
  end

  def new
  end
end
