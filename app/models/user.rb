class User < ApplicationRecord
  attr_accessor :remember_token

  self.primary_key = 'id'
  has_secure_password

  has_many :favs, dependent: :destroy
  has_many :diaries, through: :favs

  validates :email, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true

  def self.new_token #User.new_tokenと同じ意味
    SecureRandom.urlsafe_base64
  end
  
  def self.digest(string) #User.digest(string)を同じ意味
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
