# frozen_string_literal: true

class Rename < ActiveRecord::Migration[7.0]
  def change
    rename_column :dislikes, :article_id, :dislikeable_id

    add_index :dislikes, %i[dislikeable_id dislikeable_type]
  end
end
