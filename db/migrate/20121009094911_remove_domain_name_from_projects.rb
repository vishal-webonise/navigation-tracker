class RemoveDomainNameFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :domain_name
  end

  def down
    add_column :projects, :domain_name, :string
  end
end
