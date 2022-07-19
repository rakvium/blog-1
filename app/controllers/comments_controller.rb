class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article
  def create
    @comment= @article.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save

        format.html { redirect_to article_url(@article), notice: "comment was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { redirect_to article_url(@article), status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: 303
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :article_id)
  end

  def set_article
    @article= Article.find(params[:article_id])
  end
end
