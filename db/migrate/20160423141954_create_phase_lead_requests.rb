class CreatePhaseLeadRequests < ActiveRecord::Migration
  def change
    create_table :phase_lead_requests do |t|
      t.date :day
      t.integer :teacher_id
      t.integer :phase_day_id
      t.boolean :approved_by_coordinator

      t.timestamps null: false
    end
  end
end
