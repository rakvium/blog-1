# frozen_string_literal: true

class ArticlesController < ApplicationController
  include ActiveModel::Dirty
  before_action :set_article, only: %i[update]
  before_action :check_if_changed, only: %i[update]

  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.paginate(page: params[:page], per_page: 10)
    @category = Category.all
  end

  def search
    @articles = Article.where('title_or_descriprion LIKE ?', "%#{params[:q]}%").paginate(page: params[:page],
                                                                                         per_page: 10)
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.order('created_at DESC').paginate(page: params[:page], per_page: 3)
    @comment = Comment.new
    mark_notifications_as_read
  end

  def new
    @categories = Category.all
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def explore
    @articles = Article.all.shuffle
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
  end

  def update
    @user = @article.user
    @article.approved_will_change!
    # binding.irb

    SendEmailJob.perform_now(@article) if @current_value == true && check_if_changed == true
    if @article.update(article_params)
      # binding.irb
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :status, :language, :approved, :description, :body,
                                    categories_attributes: %i[name destroy], category_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def check_if_changed
    @current_value = params.require(:article)[:approved]
    @current_value = true if params.require(:article)[:approved] == '1'
    @current_value = false if params.require(:article)[:approved] == '0'
    @article.approved != @current_value
  end

  def mark_notifications_as_read
    if current_user
      notifications_to_mark_as_read = @article.notifications_as_article.where(recipient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end
end
