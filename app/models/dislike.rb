# frozen_string_literal: true

class Dislike < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[dislikeable_id dislikeable_type] }
  belongs_to :user
  belongs_to :dislikeable, polymorphic: true
end
