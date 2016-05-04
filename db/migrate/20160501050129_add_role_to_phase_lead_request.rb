class AddRoleToPhaseLeadRequest < ActiveRecord::Migration
  def change
    add_column :phase_lead_requests, :role, :integer
  end
end
