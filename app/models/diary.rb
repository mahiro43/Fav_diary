class Diary < ApplicationRecord
  belongs_to :fav, optional: false

  validates :content, presence: true

  def self.exists_on?(date)
    where("date(created_at) = ?", date).exists?
  end
end
