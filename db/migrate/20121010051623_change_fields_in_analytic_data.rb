class ChangeFieldsInAnalyticData < ActiveRecord::Migration
  def up
  	remove_column :analytic_data, :url
  	add_column :analytic_data, :visit_path, :string
  	add_column :analytic_data, :reference_path, :string
  end

  def down
  	remove_column :analytic_data, :reference_path
  	remove_column :analytic_data, :visit_path
  	add_column :analytic_data, :url, :string
  end
end
