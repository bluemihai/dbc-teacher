class AddPhaseDayIdToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :phase_day_id, :integer
    remove_column :challenges, :phase
    remove_column :challenges, :week
  end
end
