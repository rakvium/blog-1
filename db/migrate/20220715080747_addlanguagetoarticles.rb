# frozen_string_literal: true

class Addlanguagetoarticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :language, :integer
  end
end
