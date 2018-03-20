class FixProjectGroupTable < ActiveRecord::Migration
  def change
    remove_column :project_groups, :project_category_id, :integer
    remove_column :project_groups, :status_id, :integer
    remove_column :project_groups, :created_by, :integer
    remove_column :project_groups, :updated_by, :integer
    remove_column :project_groups, :created_at, :datetime
    remove_column :project_groups, :updated_at, :datetime
    add_column :project_groups, :project_category_type_code, :integer 
    add_column :project_groups, :project_category_item_code, :integer
    add_column :project_groups, :status_type_code, :integer 
    add_column :project_groups, :status_item_code, :integer 
    add_column :project_groups, :created_by, :integer
    add_column :project_groups, :modified_by, :integer
    add_column :project_groups, :created_at, :datetime,            null: false
    add_column :project_groups, :updated_at, :datetime,            null: false

  end
end

