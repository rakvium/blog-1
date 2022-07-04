class Category < ApplicationRecord
  has_many :articlecategories 
  has_many :articles, through: :articlecategories

end
