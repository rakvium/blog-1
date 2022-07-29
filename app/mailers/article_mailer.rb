class ArticleMailer < ApplicationMailer
  default from: "1surmavamariam@gmail.com"

  def approved_email
    @user = params[:user]
    @article = Article.find_by(params[:id])
    mail(to: @user.email, subject: 'Article updated')
  end
end
