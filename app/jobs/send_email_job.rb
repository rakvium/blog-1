class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(article)
    ArticleMailer.approved_email(article).deliver_now
  end
end

