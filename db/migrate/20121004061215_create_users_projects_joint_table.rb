class CreateUsersProjectsJointTable < ActiveRecord::Migration
  def change
    create_table :user_projects, :id => true do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :is_owner, :default => true
    end
    add_index :user_projects, [:project_id, :user_id]
    add_index :user_projects, [:user_id, :project_id], :unique => true
    add_index :user_projects, [:user_id, :project_id, :is_owner]
  end
end