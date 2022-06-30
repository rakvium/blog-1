class AdminController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @users = User.all
    @articles = Article.all
  end

  def edit
  end

  def update
  end

  def new
  end
end
