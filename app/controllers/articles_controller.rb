class ArticlesController < ApplicationController

    def index
      @q = Article.ransack(params[:q])
      @articles = @q.result.all.paginate(page: params[:page], per_page: 10)
      @category = Category.all

    end
   

  def search
    @articles =  Article.where("title LIKE ?", "%" + params[:q] + "%").paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.paginate(page: params[:page], per_page: 3)
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

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @approver = Approver.new
    @approver.user_id = current_user
    @approver.article_id = @article
    @approver.save

    if @article.update(article_params)
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
      format.js   { render :layout => false }
 end
  end

  private
    def article_params
      params.require(:article).permit(:title, :status, :approved, :body, categories_attributes: [:name, :destroy], category_ids: [])
    end
end
