class AddColorToDisks < ActiveRecord::Migration
  def change
    add_column :disks, :color, :string
  end
end
