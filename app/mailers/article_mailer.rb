# frozen_string_literal: true

class ArticleMailer < ApplicationMailer
  default from: '1surmavamariam@gmail.com'

  def approved_email(article)
    @user = article.user
    @article = article
    mail(to: @user.email, subject: 'Article updated')
  end
end
