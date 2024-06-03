class User < ApplicationRecord
  self.primary_key = 'id'
  has_secure_password

  has_many :favs, dependent: :destroy

  validates :email, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
end
