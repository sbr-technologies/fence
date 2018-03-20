class CustomersController < ApplicationController
  ssl_exceptions
  before_action :authenticate_user!
  before_action only: [:create, :update] { format_date_params(:customer) }
  load_and_authorize_resource :business
  load_and_authorize_resource :customer, through: :business


  def index
    @customers = @customers.includes(:contract_proposals)
  end

  def new
    @customer.addresses.build
    @customer.phones.build
  end

  def create
    @customer.assign_attributes(created_by)
    if @customer.save
      flash[:notice] = I18n.t('customer.notice')
      redirect_to business_customers_path(current_business)
    else
      render 'new'
    end
  end

  def update
    if @customer.update(customer_params.merge(modified_by))
      flash[:notice] = I18n.t('customer.update')
      redirect_to business_customers_path(current_business)
    else
      render 'edit'
    end
  end

  def destroy
    @customer.destroy
    flash[:notice] = I18n.t('customer.delete')
    redirect_to business_customers_path(current_business)
  end

  private

  def customer_params
    attr = [:business_name, :margin_percent, :last_name, :first_name, :middle_initial, :start_date, :end_date, :business_account_nmbr, :end_reason_item_code, :end_reason_notes, :status_item_code].push(contact_person_attr).push(address_attr).push(phone_attr)
    params.require(:customer).permit(attr)
  end

end
