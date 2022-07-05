class Article < ApplicationRecord
  include Visible
	belongs_to :user
  has_rich_text :body
  has_one :approver
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: lambda {|attributes| attributes[:name].blank?}
  validates_associated :categories

  def set_default_approver
    self.approver ||= nil
  end

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end