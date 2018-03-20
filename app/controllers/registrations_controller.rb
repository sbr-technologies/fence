class RegistrationsController < Devise::RegistrationsController
  ssl_exceptions
  before_filter :add_params, only: :create
  before_filter :configure_permitted_parameters

  def unique_business_name
    orgs = Business.where("lower(business_name) =?", params[:user][:business_name].to_s.downcase)
    render json: orgs.blank?
  end

  def unique_admin_email
    users = User.where("lower(email) =?", params[:user][:email].to_s.downcase)
    render json: users.blank?
  end

  protected

  def add_params
    biz = Business.create(business_name: params[:user][:business_name])
    emp = Employee.create({business_id: biz.id})
    params[:user].merge!({business_id: biz.id, role_id: Role.enterprise_admin.id, employee_id: emp.id})
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:business_id, :employee_id, :role_id)
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
