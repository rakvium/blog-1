class DropAvatarFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :avatar, :string
    add_column :users, :avatar, :string
  end
end
