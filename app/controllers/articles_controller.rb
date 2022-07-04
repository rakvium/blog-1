class ArticlesController < ApplicationController

    def index
      @q = Article.ransack(params[:q])
      @articles = @q.result.all.paginate(page: params[:page], per_page: 10)
    end
   

  def search
    @articles =  Article.where("title LIKE ?", "%" + params[:q] + "%").paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.paginate(page: params[:page], per_page: 3)
  end

  def new
    @categories = Category.all.map{|c| [c.name, c.id]}
    @article = Article.new
  end



  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @categories = Category.all
    @articlecategory = Articlecategory.new(article_id: @article.id, category_id:@categories.where('id = ?', params[:category_id].to_i))

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
      params.require(:article).permit(:title, :body, :status, :user_id)
    end
end
