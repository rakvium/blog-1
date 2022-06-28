class CommentsController < ApplicationController
  before_action :get_article



  def index
    @comments = @article.comments.all
  end

  def create
    @article = Article.find(params[:article_id])
    comment = @article.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to @article
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: 303
  end

  private
    def get_plan
      @article = Article.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :status, :user_id)
    end
end


