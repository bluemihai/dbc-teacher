class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :abbrev
      t.string :status
      t.date :starting

      t.timestamps null: false
    end
  end
end
