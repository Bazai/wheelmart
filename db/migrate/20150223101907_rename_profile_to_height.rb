class RenameProfileToHeight < ActiveRecord::Migration
  def change
    rename_column :tyre_sizes, :profile, :height
  end
end
