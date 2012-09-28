class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :domain
      t.string :git_url
      t.string :project_mgt_tool

      t.timestamps
    end
  end
end
