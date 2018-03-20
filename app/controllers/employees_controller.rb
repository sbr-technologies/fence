class EmployeesController < ApplicationController
  ssl_exceptions
  before_action :authenticate_user!
  before_action only: [:create, :update] { format_date_params(:employee) }
  load_and_authorize_resource :business
  load_and_authorize_resource :employee, through: :business

  def index
    @employees
  end

  def new
    @employee.addresses.build
    @employee.phones.build
  end

  def create
    if @employee.save
      if @employee.email_address1.present?
        flash[:notice] = I18n.t('employee.created_with_email', email: @employee.email_address1)
      else
        flash[:notice] = I18n.t('employee.created_without_email', email: @employee.email_address1)
      end
      redirect_to business_employees_path(@business)
    else
      render 'new'
    end
  end

  def update
#    previous_email = @employee.unconfirmed_email
    if @employee.update(employee_params)
#      if previous_email != @employee.unconfirmed_email
#        flash[:notice] = I18n.t('devise.registrations.update_needs_confirmation')
#      else
        flash[:notice] = I18n.t('employee.update')
#      end
      redirect_to business_employees_path(@business)
    else
      render 'edit'
    end
  end

  def destroy
    @employee.destroy
    flash[:notice] = I18n.t('employee.delete')
    redirect_to business_employees_path(@business)
  end

  private

  def employee_params
    attr =[:first_name, :last_name, :middle_initial, :employee_number, :ssn, :hourly_rate, :start_date, :end_date, :gross_salary, :taxes, :net_salary, :end_reason_notes, :end_reason_item_code, :status_item_code, :employee_item_code, :id].push(address_attr).push(phone_attr)
#    if current_employee.id == params[:employee][:id]
#      params[:employee][:need_login] = true
#    end
    params.require(:employee).permit(attr)
  end
end
