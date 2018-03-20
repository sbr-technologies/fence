require 'rails_helper'

RSpec.describe Contracts::ProjectsController, type: :controller do
  login_employee
  render_views

  context 'Amount Calculation' do
    context 'should ignore customer margin percent and should calculate according to retail price stored' do
      before do
        patch :update, project_attrs
        @project_product = assigns(:contract).projects.first.project_products.first
      end

      it 'should caluclate retail price' do
        expect(@project_product.retail).to eq(25.00)
        expect(@project_product.retail_price).to eq(2500.00)
      end

      it 'should caluclate total price' do
        expect(@project_product.price).to eq(125.00)
        expect(@project_product.total_price).to eq(12500.00)
      end

      it 'should caluclate total amount amount' do
        expect(@project_product.amount).to eq(225.00)
        expect(@project_product.total_amount).to eq(22500.00)
      end

      it 'should caluclate project amount' do
        expect(@project_product.project.amount).to eq(22500.00)
      end

      it 'should caluclate contract_amount' do
        expect(@project_product.project.contract.amt).to eq(225.00)
        expect(@project_product.project.contract.amount).to eq(22500.00)
      end
    end
  end

  def project_attrs
    org = @employee.organization
    contract = FactoryGirl.create(:contract, organization: org)
    project = FactoryGirl.create(:project, organization: org)
    project.update_attributes(of_type: Project::CONTRACT, contract: contract)
    attrs = project.project_products.last.attributes
    attrs.merge!({retail: 25})
    project_category_id = FactoryGirl.create(:project_category).id
    {
      id: project.id,
      contract_id: contract.id,
      organization_id: org.id,
      project: FactoryGirl.attributes_for(:contract_project)
      .merge(
        project_products_attributes: {'0' => attrs}
      )
    }
  end
end


