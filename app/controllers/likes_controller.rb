# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :get_dislike, only: %i[create]
  before_action :get_article

  respond_to :json, :html

  def create
    @like = current_user.likes.new(like_params)

    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save

    @dislike&.destroy
    respond_to do |format|
      format.html { redirect_to @like.likeable }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    likeable = @like.likeable
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likeable }
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type, :locale)
  end

  def get_article
    @article = Article.find_by(params[:likeable_id])
  end

  def get_dislike
    @dislike = current_user.dislikes.find_by(params[:likeable_id])
  end
end
