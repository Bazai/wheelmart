class AddDiToSizes < ActiveRecord::Migration
  def change
    add_column :sizes, :di, :float
  end
end
