require 'mini_magick'

class Diary < ApplicationRecord
  belongs_to :fav, optional: false

  has_many_attached :images

  validates :content, presence: true
<<<<<<< HEAD

  def self.exists_on?(date)
    where("date(created_at) = ?", date).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[content]
  end

  def resize_images
    images.each do |image|
      resized_image = MiniMagick::Image.read(image.download)
      resized_image.resize "600x600"
      Tempfile.open(["temp_image", ".jpg"]) do |temp_file|
        resized_image.write(temp_file.path)
        # Delete the original image
        image.purge
        # Attach the resized image
        images.attach(io: File.open(temp_file.path), filename: image.filename.to_s, content_type: image.content_type)
      end
    end
  end
end
