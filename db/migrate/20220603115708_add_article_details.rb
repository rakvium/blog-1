# frozen_string_literal: true

class AddArticleDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :user, index: true, foreign_key: true
  end
end
