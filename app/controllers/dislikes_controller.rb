# frozen_string_literal: true

class DislikesController < ApplicationController
  before_action :get_like, only: %i[create]

  def create
    @dislike = current_user.dislikes.new(dislike_params)

    flash[:notice] = @dislike.errors.full_messages.to_sentence unless @dislike.save

    @like&.destroy
    respond_to do |format|
      format.html { redirect_to @dislike.dislikeable }
    end
  end

  def destroy
    @dislike = current_user.dislikes.find(params[:id])
    dislikeable = @dislike.dislikeable

    @dislike.destroy
    respond_to do |format|
      format.html { redirect_to dislikeable }
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
