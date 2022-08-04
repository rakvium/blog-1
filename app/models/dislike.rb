# frozen_string_literal: true

class Dislike < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[dislikeable_id dislikeable_type] }
  belongs_to :user
  belongs_to :dislikeable, polymorphic: true

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
      DislikeNotification.with(dislike: self, article: self.dislikeable).deliver(self.dislikeable.user)
  end

  def cleanup_notifications
    notifications_as_dislike.destroy_all
  end
end
