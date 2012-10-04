class RenameDomainColumnOfProject < ActiveRecord::Migration
  def up
  	rename_column :projects, :domin_url, :domain_url
  end

  def down
  	rename_column :projects, :domain_url, :domin_url
  end
end
