class Fav < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImagesUploader
  has_many :diaries, dependent: :destroy
end
