class CreateLuckyvideosTable < ActiveRecord::Migration[5.2]
  def change
    create_table :luckyvideos do |t|
      t.string :title
      t.string :description
      t.string :url
      t.string :youtube_id
      t.integer :user_id
    end
  end
end