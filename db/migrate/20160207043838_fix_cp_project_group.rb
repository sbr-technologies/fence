class FixCpProjectGroup < ActiveRecord::Migration
  def change
    remove_column :cp_project_groups, :cp_pg_description, :string
    remove_column :cp_project_groups, :cp_pg_long_description, :text
    remove_column :cp_project_groups, :cp_pg_amount, :float
    remove_column :cp_project_groups, :status_id, :integer
    remove_column :cp_project_groups, :created_by, :integer
    remove_column :cp_project_groups, :updated_by, :integer
    remove_column :cp_project_groups, :created_at, :datetime
    remove_column :cp_project_groups, :updated_at, :datetime
    add_column :cp_project_groups, :cp_pg_description, :string
    add_column :cp_project_groups, :cp_pg_long_description, :text
    add_column :cp_project_groups, :cp_pg_amount, :float,           default: 0.0
    add_column :cp_project_groups, :status_type_code, :integer 
    add_column :cp_project_groups, :status_item_code, :integer 
    add_column :cp_project_groups, :created_by, :integer
    add_column :cp_project_groups, :modified_by, :integer
    add_column :cp_project_groups, :created_at, :datetime,            null: false
    add_column :cp_project_groups, :updated_at, :datetime,            null: false

  end
end




