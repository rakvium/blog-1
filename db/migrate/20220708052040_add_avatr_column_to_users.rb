class AddAvatrColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :avatar, :string
  end
end
