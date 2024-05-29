class AddAddressToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :address, :string
  end
end
