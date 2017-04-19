class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :password, presence: true, length: { minimum: 6 }

  has_many :posts

    def self.from_omniauth(auth)
      where(email: auth.info.email).first_or_create do |user|
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.nickname # assuming the user model has a name
      end
    end
end
