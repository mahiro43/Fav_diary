class User < ApplicationRecord
  attr_accessor :remember_token

  self.primary_key = 'id'
  has_secure_password

  has_many :favs, dependent: :destroy

  validates :email, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # クラスメソッド
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    BCrypt::Password.create(token)
  end
end
