class CreateTyres < ActiveRecord::Migration
  def change
    create_table :tyres do |t|
      t.float :diameter
      t.float :width
      t.float :height
      t.string :full_name
      t.integer :price
      t.string :season
      t.string :brand_name
      t.string :name
      t.string :spikes
      t.string :speed

      t.timestamps
    end
  end
end
