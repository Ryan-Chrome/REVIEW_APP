class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject
      t.text :content
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
