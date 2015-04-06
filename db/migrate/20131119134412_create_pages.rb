class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :header
      t.datetime :counter
      t.string :action
      t.string :phone
      t.string :address
      t.string :work_time

      t.timestamps
    end
  end
end
