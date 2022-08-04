# frozen_string_literal: true

class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  after_initialize :set_default_status, if: :new_record?
  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  def set_default_status
    self.status ||= 'public'
  end

  validates :body, presence: true

  private

  def notify_recipient
      CommentNotification.with(comment: self, article: article).deliver(article.user)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end
