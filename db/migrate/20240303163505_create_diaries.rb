class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.uuid :fav_id, null: false
      t.date :date
      t.text :content

      t.timestamps
    end

    add_foreign_key :diaries, :favs, column: :fav_id
  end
end
