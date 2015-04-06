class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.float :width
      t.float :diameter
      t.integer :bolt_count
      t.float :bolt_distance
      t.float :et

      t.timestamps
    end
  end
end
