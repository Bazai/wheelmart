class CreateDisks < ActiveRecord::Migration
  def change
    create_table :disks do |t|
      t.float :width
      t.float :diameter_diska
      t.integer :bolt_count
      t.float :bolt_distance
      t.float :et
      t.float :diameter
      t.belongs_to :brand
      t.float :price

      t.timestamps
    end
  end
end
