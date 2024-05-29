class AddLocationToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :latitude, :float
    add_column :diaries, :longitude, :float
  end
end
