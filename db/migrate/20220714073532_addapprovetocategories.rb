# frozen_string_literal: true

class Addapprovetocategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :approved, :boolean, default: false
  end
end
