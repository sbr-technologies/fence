class FixContractProposal < ActiveRecord::Migration
  def change
    remove_column :contract_proposals, :status_id, :integer
    remove_column :contract_proposals, :created_by, :integer
    remove_column :contract_proposals, :updated_by, :integer
    remove_column :contract_proposals, :created_at, :datetime
    remove_column :contract_proposals, :updated_at, :datetime
    add_column :contract_proposals, :status_type_code, :integer 
    add_column :contract_proposals, :status_item_code, :integer 
    add_column :contract_proposals, :created_by, :integer
    add_column :contract_proposals, :modified_by, :integer
    add_column :contract_proposals, :created_at, :datetime,            null: false
    add_column :contract_proposals, :updated_at, :datetime,            null: false
  end
end

