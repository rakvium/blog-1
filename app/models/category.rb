# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories

  validates :name, uniqueness: true
end
