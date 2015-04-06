class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.integer :year
      t.belongs_to :mark, index: true
      t.belongs_to :model, index: true

      t.timestamps
    end
  end
end
