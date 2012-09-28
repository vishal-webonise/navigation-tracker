class CreateAnalyticData < ActiveRecord::Migration
  def change
    create_table :analytic_data do |t|
      t.integer :project_id
      t.string :url
      t.string :ip_address

      t.timestamps
    end
  end
end
