class SuppliersController < ApplicationController
  ssl_exceptions
  before_action :authenticate_user!
  before_action only: [:create, :update] { format_date_params(:supplier) }
  load_and_authorize_resource :business
  load_and_authorize_resource :supplier, through: :business

  def new
    @supplier.addresses.build
    @supplier.phones.build
    @supplier.contact_persons.build
  end

  def create
    @supplier.assign_attributes(created_by)
    if @supplier.save
      flash[:notice] = I18n.t('supplier.notice')
      redirect_to business_suppliers_path(current_business)
    else
      render 'new'
    end
  end

  def update
    if @supplier.update(supplier_params.merge(modified_by))
      flash[:notice] = I18n.t('supplier.update')
      redirect_to business_suppliers_path(current_business)
    else
      render 'edit'
    end
  end

  def destroy
    @supplier.destroy
    flash[:notice] = I18n.t('supplier.delete')
    redirect_to business_suppliers_path(current_business)
  end

  private

  def supplier_params
    attrs = [:business_name, :business_account_number, :first_name, :last_name, :middle_initial, :start_date, :end_date, :end_reason_item_code, :end_reason_notes, :status_item_code].push(contact_person_attr).push(address_attr).push(phone_attr)
    params.require(:supplier).permit(attrs)
  end
end
