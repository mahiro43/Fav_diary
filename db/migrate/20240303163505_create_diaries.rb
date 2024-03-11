class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.references :fav, null: false, foreign_key: true
      t.date :date
      t.text :content

      t.timestamps
    end
  end
end
