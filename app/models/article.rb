class Article < ApplicationRecord
  include Visible
	belongs_to :user
  has_rich_text :body
  has_many :articlecategories
  has_many :categories, through: :articlecategories



  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end