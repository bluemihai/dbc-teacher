class AddAdvisorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :advisor_id, :integer
  end
end
