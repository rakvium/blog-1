class ArticlesController < ApplicationController

    def index
      @q = Article.ransack(params[:q])
      @articles = @q.result.paginate(page: params[:page], per_page: 10)
      @category = Category.all
    end
   

  def search
    @articles =  Article.where("title_or_descriprion LIKE ?", "%" + params[:q] + "%").paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.order('created_at DESC').paginate(page: params[:page], per_page: 3)
    @comment=Comment.new
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
    @categories = Category.all
  end

  def update
    @article = Article.find(params[:id])

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
      params.require(:article).permit(:title, :status, :language, :approved,:description, :body, categories_attributes: [:name, :destroy], category_ids: [])
    end
end
