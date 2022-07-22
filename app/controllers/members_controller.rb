class MembersController < ApplicationController
  def articles
    @q = Article.ransack(params[:q])
    @articles = @q.result.where("status = ?", "members only").paginate(page: params[:page], per_page: 10)
    @category = Category.all
  end
 

def search
  @articles =  Article.where("title_or_descriprion LIKE ?", "%" + params[:q] + "%").paginate(page: params[:page], per_page: 10)
end
end
