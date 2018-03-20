require 'rails_helper'

RSpec.describe Project, type: :model do
  
  context '#calculate_amount'  do
    it 'update amount after save' do
      project = FactoryGirl.create(:project)
      expect(project.amount).to eq(17500.0)
      product = FactoryGirl.create(:product, organization_id: project.organization_id)
      project.project_products << FactoryGirl.build(:project_product, product_id: product.id )
      project.save
      expect(project.amount).to eq(27500.0)
    end
  end

  context 'Contract Project' do
    it 'should calculate project_products amount' do
      project = FactoryGirl.create(:project)
      project_product = project.project_products.last
      expect(project_product.total_amount).to eq(17500.0)
      expect(project_product.total_price).to eq(7500.0)
      expect(project_product.retail_price).to eq(1500.0)
      expect(project_product.project_id).to eq(project.id)
      expect(project.amount).to eq(17500.0)
    end
  end

  context 'Contract Project' do
    it 'should copy project_products to contract_project' do
      project = FactoryGirl.create(:project)
      expect(project.project_products.size).to eq(1)
      contract_project = FactoryGirl.create(:contract_project, copy_project_id: project.id)
      expect(contract_project.of_type).to eq(Project::CONTRACT)
      expect(contract_project.amount).to eq(17500.0)
      expect(contract_project.project_products.size).to eq(1)
      project_product = contract_project.project_products.last
      expect(project_product.total_amount).to eq(17500.0)
      expect(project_product.total_price).to eq(7500.0)
      expect(project_product.retail_price).to eq(1500.0)
      expect(project_product.project_id).to eq(contract_project.id)
      expect(project_product.id).not_to eq(project.project_products.last.id)
    end
  end
end
