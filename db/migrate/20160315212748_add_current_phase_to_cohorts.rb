class AddCurrentPhaseToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :current_phase, :integer
  end
end
