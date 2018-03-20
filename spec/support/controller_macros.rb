module ControllerMacros
  def login_employee
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @employee = FactoryGirl.create(:employee)
      sign_in @employee
    end
  end
end

