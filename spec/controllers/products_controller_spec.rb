require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  login_employee
  render_views

  before(:each) do
    @product = FactoryGirl.create(:product, organization_id: @employee.organization_id)
  end

  context '#index' do
    it 'render index page of products' do
      get :index, organization_id: @employee.organization_id
      expect(response).to render_template('index')
    end

    it 'should loads product associated with current organization' do
      get :index, organization_id: @employee.organization_id
      expect(assigns(:products)).to include(@product)
    end

    it 'should not include the other organization products' do
      organization = FactoryGirl.create(:organization)
      @product.update_attribute(:organization_id, organization.id)
      get :index, organization_id: @employee.organization_id
      expect(assigns(:products).empty?).to be true
    end
  end

  context '#new' do
    it 'should render the new page' do
      get :new, organization_id: @employee.organization_id
      expect(response).to render_template('new')
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  context '#create' do
    context 'sucessful' do

      it 'should create new product record' do
        expect(Product.count).to eq(1)
        post :create, product_attrs
        product = assigns(:product)
        expect(Product.count).to eq(2)
        expect(product.sku).to eq('123')
        expect(product.name).to eq('some name')
        expect(product.description).to eq('12x13 ss Brand and more clamp')
        expect(product.supplier_id).to eq(@supplier.id)
        expect(product.product_category_id).to eq(@product_category.id)
        expect(product.unit_of_measurement.id).to eq(@unit_of_measurement.id)
        expect(product.long_description).to eq('12x13 ss Brand and more description')
        expect(product.organization_id).to eq(@employee.organization_id)
        expect(product.product_rates.size).to eq(1)
        expect(product.product_rates.first.cost).to eq(19)
        expect(product.product_rates.first.retail).to eq(20)
        expect(product.product_rates.first.cost_price).to eq(1900)
        expect(product.product_rates.first.retail_price).to eq(2000)
      end

      it 'page should redirects to products listing page' do
        expect(Product.count).to eq(1)
        post :create, product_attrs
        expect(Product.count).to eq(2)
        expect(response).to redirect_to organization_products_path(assigns(:organization), assigns(:products))
      end
    end

    context 'unsuccessful' do
      it 'should not create product record and renders the new page with errors' do
        expect {
          post :create, organization_id: @employee.organization_id, product: FactoryGirl.attributes_for(:product, name: "")
        }.to change { Product.count}.by (0)
        expect(response).to render_template('new')
      end
    end
  end


  context '#update' do
    context 'successful' do
      it 'should update product record' do
        @new_supplier = FactoryGirl.create(:supplier, organization_id: @employee.organization_id)
        @unit_of_measurement = FactoryGirl.create(:unit_of_measurement, organization_id: @employee.organization_id)
        @product_category = FactoryGirl.create(:product_category, organization_id: @employee.organization_id)
        attrs = product_attrs.merge({id: @product.id})
        attrs[:product][:sku] = '431'
        attrs[:product][:name] = 'some name'
        attrs[:product][:description] = 'description short'
        attrs[:product][:supplier_id] = @new_supplier.id
        attrs[:product][:product_category_id] = @product_category.id
        attrs[:product][:unit_of_measurement] = @unit_of_measurement.id
        attrs[:product][:long_description] = 'some long description'
        attrs[:product][:status] = 'Active'
        attrs[:product][:product_rates_attributes]['0'].merge!({ 'cost' => 21, 'retail' => 28, 'id' => @product.product_rates.last.id})
        put :update, attrs
        product = assigns(:product)
        expect(product.sku).to eq('431')
        expect(product.name).to eq('some name')
        expect(product.description).to eq('description short')
        expect(product.supplier_id).to eq(@new_supplier.id)
        expect(product.product_category_id).to eq(@product_category.id)
        expect(product.unit_of_measurement_id).to eq(@unit_of_measurement.id)
        expect(product.long_description).to eq('some long description')
        expect(product.status).to eq('Active')
        expect(product.organization_id).to eq(@employee.organization_id)
        expect(product.product_rates.first.cost).to eq(21)
        expect(product.product_rates.first.retail).to eq(28)
        expect(product.product_rates.first.cost_price).to eq(2100)
        expect(product.product_rates.first.retail_price).to eq(2800)
      end

      it 'page should redirects to products listing' do
        put :update, organization_id: @employee.organization_id, id: @product.id, product: { name: "123sku"}
        expect(response).to redirect_to organization_products_path(assigns(:organization))
      end
    end

    context 'unsucessful' do
      it 'should not update the product if name is missing and render the edit page' do
        product_attributes = FactoryGirl.attributes_for(:product, name: "")
        put :update, organization_id: @employee.organization_id, id: @product, product: product_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  context '#destroy' do
    it 'deletes the product' do
      expect{ delete :destroy, id: @product, organization_id: @employee.organization_id }.to change(Product,:count).by(-1)
    end
  end

  def product_attrs
    @product_category = FactoryGirl.create(:product_category, organization_id: @employee.organization_id)
    @supplier = FactoryGirl.create(:supplier, organization_id: @employee.organization_id)
    @manufacturer  = FactoryGirl.create(:manufacturer, organization_id: @employee.organization_id)
    @unit_of_measurement = FactoryGirl.create(:unit_of_measurement, organization_id: @employee.organization_id)
    {
      product: FactoryGirl.attributes_for(:product, sku: '123', name: 'some name', supplier_id: @supplier.id, manufacturer_id: @manufacturer.id, product_category_id: @product_category.id, unit_of_measurement_id: @unit_of_measurement.id, product_rates_attributes: { "0" => {"cost" => 19, "retail" => 20}} ),
      organization_id: @employee.organization_id
    }
  end
end
