class Droptablearticlecat < ActiveRecord::Migration[7.0]
  def change
    drop_table :articlecategories
  end
end
