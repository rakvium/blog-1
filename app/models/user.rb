class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 
  enum role: [:user, :member, :admin]
  mount_uploader :avatar, AvatarUploader

  after_initialize :set_default_role, :if => :new_record?


  def set_default_role
    self.role ||= :user
  end

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

    devise :omniauthable, omniauth_providers: [:google_oauth2]
    
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :dislikes, dependent: :destroy
    has_many :phones, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    has_many :places, dependent: :destroy

    # User Avatar Validation
    def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first
  
      # Uncomment the section below if you want users to be created if they don't exist
      unless user
          user = User.create(
             email: data['email'],
             user_name: data['email'].split("@").first.gsub(/[^0-9a-zA-Z]/i, '').downcase[0,12],
             password: Devise.friendly_token[0,20],
             confirmed_at: Time.now
          )
          # user.skip_confirmation!
          return { user: user, new_user: true }
      end
     { user: user, new_user: false }
    end


end
