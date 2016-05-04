class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :url
      t.integer :kind
      t.integer :phase_day_id
      t.string :source
      t.date :last_shared
      t.text :description
      t.integer :usefulness_rating

      t.timestamps null: false
    end
  end
end
