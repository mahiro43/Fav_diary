class User < ApplicationRecord
  has_secure_password

  has_many :favs, dependent: :destroy

  validates :email, uniqueness: true
end
