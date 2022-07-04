class DropCategorizesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :categorizes
  end
end
