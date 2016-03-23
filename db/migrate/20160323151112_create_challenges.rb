class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :phase
      t.integer :week
      t.string :github_repo
      t.text :description

      t.timestamps null: false
    end
  end
end
