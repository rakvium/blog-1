class CreateDislikes < ActiveRecord::Migration[7.0]
  def change
    create_table :dislikes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :dislikeable_type
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
