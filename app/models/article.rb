class Article < ApplicationRecord
  include Visible
	belongs_to :user
  has_rich_text :body
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: lambda {|attributes| attributes[:name].blank?}
  validates_associated :categories



  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end