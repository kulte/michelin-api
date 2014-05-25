class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :chef
      t.integer :stars
      t.integer :comfort
      t.integer :district_id
      t.integer :area_id

      t.timestamps
    end
  end
end
