class CreateFavs < ActiveRecord::Migration[7.1]
  def change
    create_table :favs, id: :uuid do |t|
      t.string :name
      t.string :nickname
      t.date :birthday
      t.string :color
      t.text :comments
      t.string :image
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
