class CreateArticlecategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
  def change
    create_table :article_categories do |t|
      t.references :article, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
