class AddModToSizes < ActiveRecord::Migration
  def change
    add_reference :sizes, :mod, index: true
  end
end
