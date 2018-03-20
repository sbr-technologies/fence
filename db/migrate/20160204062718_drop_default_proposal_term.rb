class DropDefaultProposalTerm < ActiveRecord::Migration
  def change
    drop_table :default_proposal_terms
  end
end
