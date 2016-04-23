class CreatePhaseDays < ActiveRecord::Migration
  def change
    create_table :phase_days do |t|
      t.string :title
      t.integer :phase_no
      t.integer :day_no
      t.boolean :lead_required, default: true

      t.timestamps null: false
    end
  end
end
