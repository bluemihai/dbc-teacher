class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :name
      t.string :github_name
      t.date :phase_1_start
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
