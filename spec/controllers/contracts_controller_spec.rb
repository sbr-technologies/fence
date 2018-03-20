require 'rails_helper'

RSpec.describe ContractsController, type: :controller do
  login_employee
  render_views

  before(:each) do
    @contract = FactoryGirl.create(:contract, organization: @employee.organization)
  end

  context '#index' do
    it 'should render index page' do
      get :index, organization_id: @employee.organization_id
      expect(response).to render_template('index')
    end

    it 'should loads contract associated with the organization' do
      get :index, organization_id: @employee.organization_id
      expect(assigns(:contracts)).to include(@contract)
    end

    it 'should not include the contract of other organization' do
      new_org = FactoryGirl.create(:organization)
      @contract.update_attribute(:organization_id, new_org.id)
      get :index, organization_id: @employee.organization_id
      expect(assigns(:contracts).empty?).to be true
    end
  end

  context '#new' do
    it 'should render new contract page' do
      get :new, organization_id: @employee.organization_id
      expect(response).to render_template('new')
      expect(assigns(:contract)).to be_a_new(Contract)
    end
  end

  context '#create' do
    context 'sucessful' do
      it 'should save and render edit page if contract is valid and if user clicks on "Save & Manage Proudct" button' do
        expect(Contract.count).to eq(1)
        post :create, contract_attrs
        contract = assigns(:contract)
        expect(Contract.count).to eq(2)
        expect(contract.customer_id).to eq(@customer.id)
        expect(contract.proposal_date).to eq(Date.today)
        expect(contract.approx_start_date).to eq(Date.today.strftime("%b %m %Y"))
        expect(contract.approx_completion_date).to eq(Date.today.strftime("%b %m %Y"))
        expect(contract.start_date).to eq(Date.today)
        expect(contract.completion_date).to eq(Date.tomorrow)
        expect(contract.signed_date).to eq(Date.today)
        expect(contract.amt.to_f).to eq(175.0)
        expect(contract.advance).to eq(100)
        expect(contract.amount).to eq(17500.0)
        expect(contract.advance_payment).to eq(10000)
        expect(contract.first_name).to eq('First Name')
        expect(contract.last_name).to eq('Last Name')
        expect(contract.middle_name).to eq('M')
        expect(contract.proposal_terms).to eq('<p>Hi</p>')
        expect(contract.payment_terms).to eq('<p>Hi</p>')
        expect(contract.addn_provisions).to eq('<p>Hi</p>')
        expect(contract.organization_id).to eq(@employee.organization_id)
        expect(contract.projects.size).to be(1)
        expect(contract.projects.first.of_type).to eq(Project::CONTRACT)
        expect(response).to redirect_to edit_organization_contract_path(@employee.organization, contract)
      end

      it 'should save and redirect_to index page if contract is valid and if user clicks on "Save" button' do
        expect(Contract.count).to eq(1)
        post :create, contract_attrs_update
        contract = assigns(:contract)
        expect(Contract.count).to eq(2)
        expect(contract.projects.size).to be(1)
        expect(response).to redirect_to organization_contracts_path(assigns(:organization))
      end

      context 'Amount Calculation' do
        context 'Customer with 0 margin percent' do
          before do
            expect(Contract.count).to eq(1)
            post :create, contract_attrs
            @project_product = assigns(:contract).projects.first.project_products.first
            expect(@project_product.product.product_rates.first.retail).to eq(15.00)
            expect(@project_product.product.product_rates.first.cost).to eq(8.00)
          end

          it 'should caluclate retail price' do
            expect(@project_product.retail).to eq(15.00)
            expect(@project_product.retail_price).to eq(1500.00)
          end

          it 'should caluclate total price' do
            expect(@project_product.price).to eq(75.00)
            expect(@project_product.total_price).to eq(7500.00)
          end

          it 'should caluclate total amount amount' do
            expect(@project_product.amount).to eq(175.00)
            expect(@project_product.total_amount).to eq(17500.00)
          end

          it 'should caluclate project amount' do
            expect(@project_product.project.amount).to eq(17500.00)
          end

          it 'should caluclate contract_amount' do
            expect(@project_product.project.contract.amt).to eq(175.00)
            expect(@project_product.project.contract.amount).to eq(17500.00)
          end
        end

        context 'Customer with margin percent greater than zero' do
          before do
            expect(Contract.count).to eq(1)
            attrs  = contract_attrs
            @customer.update_column(:margin_percent, 10)
            post :create, attrs
            @project_product = assigns(:contract).projects.first.project_products.first
          end

          it 'should caluclate retail price' do
            expect(@project_product.retail).to eq(8.80)
            expect(@project_product.retail_price).to eq(880.00)
          end

          it 'should caluclate total price' do
            expect(@project_product.price).to eq(44.00)
            expect(@project_product.total_price).to eq(4400.00)
          end

          it 'should caluclate total amount amount' do
            expect(@project_product.amount).to eq(144.00)
            expect(@project_product.total_amount).to eq(14400.00)
          end

          it 'should caluclate project amount' do
            expect(@project_product.project.amount).to eq(14400.00)
          end

          it 'should caluclate contract_amount' do
            expect(@project_product.project.contract.amt).to eq(144.00)
            expect(@project_product.project.contract.amount).to eq(14400.00)
          end
        end
      end

    end

    context 'unsucessful' do
      it 'should not create contract record and should renders new page with errors' do
        expect {
              post :create, organization_id: @employee.organization_id, contract: FactoryGirl.attributes_for(:contract)
        }.to change { Contract.count}.by (0)
        expect(response).to render_template('new')
      end
    end
  end

  context '#edit' do
    it 'should render edit contract page' do
      get :edit, organization_id: @employee.organization_id, id: @contract.id
      expect(response).to render_template('edit')
    end
  end

  context '#update' do
    context 'sucessful' do
      it 'should be able to update the contract record' do
        attrs = contract_attrs_update.merge({id: @contract.id})
        attrs[:contract][:first_name] = 'sam' 
        put :update, attrs
        contract = assigns(:contract)
        expect(assigns(:contract).first_name).to eq 'sam'
        expect(response).to redirect_to organization_contracts_path(assigns(:organization))
      end

      it 'should be able to add projects to existing contract' do
        attrs = contract_attrs_new
        expect(Contract.count).to eq(1)
        post :create, contract_attrs_new
        expect(Contract.count).to eq(2)
        contract = assigns(:contract)
        expect(contract.projects.size).to be(2)
        expect(response).to redirect_to edit_organization_contract_path(@employee.organization, contract)
      end

      it 'should be able to delete project from existing contract projects list' do
        attrs = contract_attrs.merge({id: @contract.id})
        attrs[:contract]['projects_attributes']['0']['_destroy'] = 'true'
        put :update, attrs
        contract = assigns(:contract)
        expect(contract.projects.size).to be(0)
      end
    end

    context 'unsucessful' do
      it 'should not update invalid contract record and should render the edit page' do
        attrs = contract_attrs.merge({id: @contract.id})
        attrs[:contract][:proposal_date] = ''
        put :update, attrs
        expect(response).to render_template('edit')
      end
    end
  end

  context '#destroy' do
    it 'should successfully delete the contract and redirect to index page' do
      expect{ delete :destroy, organization_id: @employee.organization_id, id: @contract}.to change(Contract, :count).by(-1)
      delete :destroy, organization_id: @employee.organization_id, id: @contract.id
      expect(response).to redirect_to organization_contracts_path(@employee.organization)
    end
  end

  def contract_attrs
    project = FactoryGirl.create(:project, organization_id: @employee.organization_id)
    project_attr = { '0'=>{'copy_project_id'=> project.id, 'of_type'=>'CONTRACT', '_destroy'=>'false'} }
    @customer = FactoryGirl.create(:customer)
    {
      contract: FactoryGirl.attributes_for(:contract, customer_id: @customer.id).merge('projects_attributes' => project_attr),
      commit: 'Save and Manage Projects',
      organization_id: @employee.organization_id
    }
  end
  
  def contract_attrs_update
    @project = FactoryGirl.create(:project, organization_id: @employee.organization_id)
    project_attr = { '0'=>{'copy_project_id'=> @project.id, 'of_type'=>'CONTRACT', '_destroy'=>'false'} }
    customer = FactoryGirl.create(:customer)
    {
      contract: FactoryGirl.attributes_for(:contract, customer_id: customer.id).merge('projects_attributes' => project_attr),
      commit: 'Save',
      organization_id: @employee.organization_id
    }
  end

  def contract_attrs_new
    project1 = FactoryGirl.create(:project, organization_id: @employee.organization_id)
    project2 = FactoryGirl.create(:project, organization_id: @employee.organization_id)
    project_attr = { '0' => {'copy_project_id'=> project1.id, 'of_type'=>'CONTRACT', '_destroy'=>'false'},
                     '1' => {'copy_project_id'=> project2.id, 'of_type'=>'CONTRACT', '_destroy'=>'false'}}
    @customer = FactoryGirl.create(:customer)
    {
      contract: FactoryGirl.attributes_for(:contract, customer_id: @customer.id).merge('projects_attributes' => project_attr),
      commit: 'Save and Manage Projects',
      organization_id: @employee.organization_id
    }
  end
end
