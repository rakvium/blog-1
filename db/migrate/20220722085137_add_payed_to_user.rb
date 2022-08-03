# frozen_string_literal: true

class AddPayedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :payed, :boolean, default: false
  end
end
