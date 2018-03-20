class ManufacturersController < ApplicationController
  ssl_exceptions
  before_action :authenticate_user!
  before_action only: [:create, :update] { format_date_params(:manufacturer) }
  load_and_authorize_resource :business
  load_and_authorize_resource :manufacturer, through: :business

  def new
    @manufacturer.addresses.build
    @manufacturer.phones.build
    @manufacturer.contact_persons.build
  end

  def create
    @manufacturer.assign_attributes(created_by)
    if @manufacturer.save
      flash[:notice] = I18n.t('manufacturer.notice')
      redirect_to business_manufacturers_path(@business)
    else
      render 'new'
    end
  end

  def update
    if @manufacturer.update(manufacturer_params.merge(modified_by))
      flash[:notice] = I18n.t('manufacturer.update')
      redirect_to business_manufacturers_path(@business)
    else
      render 'edit'
    end
  end

  def destroy
    @manufacturer.destroy
    flash[:notice] = I18n.t('manufacturer.delete')
    redirect_to business_manufacturers_path(@business)
  end

  private

  def manufacturer_params
    attrs = [:business_name, :last_name, :first_name, :middle_initial, :business_account_number, :start_date, :end_date, :end_reason_item_code, :end_reason_notes, :status_item_code].push(contact_person_attr).push(address_attr).push(phone_attr)
    params.require(:manufacturer).permit(attrs)
  end
end
