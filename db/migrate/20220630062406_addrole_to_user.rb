class AddroleToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role, index: true, foreign_key: true
  end
end
