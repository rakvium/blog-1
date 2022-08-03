# frozen_string_literal: true

namespace :inactive do
  desc 'deletes articles that are created more than 10 days ago and do not have any comments, likes or dislikes'
  task delete: :environment do
    Article.all.each do |article|
      if (Time.now.to_datetime - article.created_at.to_datetime).to_i > 10 && (article.likes.count + article.dislikes.count + article.comments.count).zero?
        article.destroy
        puts 'done'
      end
    end
  end
end
