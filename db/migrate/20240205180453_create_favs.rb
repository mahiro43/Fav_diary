class CreateFavs < ActiveRecord::Migration[7.1]
  def change
    create_table :favs do |t|
      t.string :name
      t.string :nickname
      t.date :birthday
      t.string :color
      t.text :comments
      t.string :image

      t.timestamps
    end
  end
end
