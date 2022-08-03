# frozen_string_literal: true

class Adminaproves < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :approved, :boolean, default: false
  end
end
