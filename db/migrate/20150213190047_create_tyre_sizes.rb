class CreateTyreSizes < ActiveRecord::Migration
  def change
    create_table :tyre_sizes do |t|
      t.belongs_to :mod, index: true
      t.float :diameter
      t.float :width
      t.float :profile

      t.timestamps
    end
  end
end
