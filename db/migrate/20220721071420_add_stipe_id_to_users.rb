# frozen_string_literal: true

class AddStipeIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_id, :string
  end
end
