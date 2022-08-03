# frozen_string_literal: true

class AddAvatrColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :avatar, :string
  end
end
