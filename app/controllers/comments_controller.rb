class CommentsController < ApplicationController
  before_action :get_article
  require 'will_paginate/array'


  def index
    @comments = @article.comments
  end

  def show
    @comments = @article.comments
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params.merge(user_id: current_user.id))
    if @article.save
      redirect_to @article
    else
      redirect_to @article
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: 303
  end

  private
    def get_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :status, :user_id)
    end
end


