class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  after_initialize :set_default_status, :if => :new_record?


  def set_default_status
    self.status ||= "public"
  end

  validates :body, presence: true

end
