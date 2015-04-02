class CreateMods < ActiveRecord::Migration
  def change
    create_table :mods do |t|
      t.string :name
      t.belongs_to :mark, index: true
      t.belongs_to :model, index: true
      t.belongs_to :year, index: true
      t.text :sizes
      t.timestamps
    end
  end
end
