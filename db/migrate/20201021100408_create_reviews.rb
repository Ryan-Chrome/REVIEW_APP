class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :content, null: false
      t.float :rate, null: false, default: 0
      t.string :category, null: false

      t.timestamps
    end
  end
end
