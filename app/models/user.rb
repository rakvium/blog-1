class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: [:user, :member, :admin]
  mount_uploader :avatar, AvatarUploader

  after_initialize :set_default_role, :if => :new_record?


  def set_default_role
    self.role ||= :user
  end

   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :dislikes, dependent: :destroy
    has_many :phones, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    has_many :places, dependent: :destroy

    # User Avatar Validation


end
