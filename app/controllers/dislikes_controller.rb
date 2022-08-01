class DislikesController < ApplicationController
  before_action :get_like, only: %i[create]
  before_action :get_article

    def create
      @dislike = current_user.dislikes.new(dislike_params)
  
      if !@dislike.save 
        flash[:notice] = @dislike.errors.full_messages.to_sentence
      end

      @like.destroy  if !@like.nil?
      respond_to do |format|
        format.html { redirect_to article_url(@article) }
      end
    end
  
  def destroy
    @dislike = current_user.dislikes.find(params[:id])
    @dislike.destroy
    respond_to do |format|
      format.html { redirect_to article_url(@article) }
    end
  end
  
   private
  
   def dislike_params
    params.require(:dislike).permit(:dislikeable_id, :dislikeable_type, :locale)
   end

   def get_like
    @like = current_user.likes.find_by(params[:dislikeable_id])
   end

   def get_article
    @article = Article.find_by(params[:likeable_id])
   end

end
