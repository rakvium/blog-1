class LanguageController < ApplicationController
  before_action :set_language
  def show
  @languages=Article.languages
  @articles = Article.where("language = ? " , params[:language].split("/")[1]).paginate(page: params[:page], per_page: 10) 
  end

  private

  def set_language
      @language = Article.languages
  end
end
