class AddGithubHashToUsers < ActiveRecord::Migration
  def up
    execute "create extension hstore"
    add_column :users, :github_hash, :hstore
  end

  def down
    remove_column :users, :github_hash
  end
end
