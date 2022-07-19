class Phone < ApplicationRecord
  belongs_to :user

  validates_format_of :phone, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
end
