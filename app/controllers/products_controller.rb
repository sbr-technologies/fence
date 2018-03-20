class ProductsController < ApplicationController
  ssl_exceptions
  before_action :authenticate_user!
  load_and_authorize_resource :business, except: :dashboard
  load_and_authorize_resource :product, through: :business, except: :dashboard
  before_action :load_supplier_and_manufacturer, except:  [:index, :destroy, :dashboard]

  def index
    @products
    respond_to do |format|
      format.html
      format.json { render json: ProductsDatatable.new(view_context, @products) }
    end
  end

#  def new
#    @product.product_rates.build
#  end

  def create
    if @product.save
      flash[:notice] = I18n.t('product.notice')
      redirect_to business_products_path(@business)
    else
      render 'new'
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = I18n.t('product.update')
      redirect_to business_products_path(@business)
    else
      render 'edit'
    end
  end

  def destroy
    # TODO: Check for dependent destroy of project_products
    @product.destroy
    flash[:notice] = I18n.t('product.delete')
    redirect_to business_products_path(@business)
  end

  def dashboard
    @business = current_business
  end

  private

  def product_params
    params.require(:product).permit(:product_sku, :product_name, :category_item_code, :uom_item_code, :preferred_supplier_id, :manufacturer_id, :description, :long_description, :cost_price, :retail_price, :status_item_code)
  end

  def load_supplier_and_manufacturer
    @suppliers = @business.suppliers
    @manufacturers = @business.manufacturers
    if @suppliers.empty? or @manufacturers.empty?
      flash.now[:notice] = I18n.t('product.prerequisite_msg')
    end
  end
end
