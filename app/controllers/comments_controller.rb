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

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = @article.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_url(@article), notice: 'Comment has been updated' }
      else
        format.html { redirect_to article_url(@article), alert: 'Comment was not updated!' }
      end
    end
  end

  
  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.update(comment_params)
  #     redirect_to @article
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

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
