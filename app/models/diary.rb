class Diary < ApplicationRecord
  belongs_to :fav, optional: false

  validates :content, presence: true
end
