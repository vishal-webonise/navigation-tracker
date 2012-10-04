class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :domain_name
      t.string :domin_url

      t.timestamps
    end
  end
end