class ContractProposalsController < ApplicationController
  ssl_exceptions [:print]
  before_action :authenticate_user!
  before_action only: [:create, :update] { format_date_params(:contract_proposal) }
  load_and_authorize_resource :business
  load_and_authorize_resource :contract_proposal, through: :business

  def print_multiple
    contracts = JSON.parse(params[:contract_ids]);
    @contract_proposals = ContractProposal.find(contracts)
    
    @address = @business.address
    @phone = @business.phones.where(is_primary: true)
    if @phone.present?
      @phone = @phone.first
    else
      @phone = @business.phones.first
    end
    @contact = @business.contact_persons.first
    
#    render :text => @projects.inspect
    html = render_to_string(layout: false, :template => 'contract_proposals/print_multiple.html.haml')
#    kit = PDFKit.new(html, :header => name_business_pdf_index_url(@business))
    kit = PDFKit.new(html, :footer_center => "Page [page] of [toPage]")
    kit.stylesheets << "#{Rails.root}/vendor/assets/stylesheets/style.css"
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/print_multiple.css"
    send_data(kit.to_pdf, filename: "contracts.pdf", type: 'application/pdf')
  end

  def destroy
    @contract.destroy
    flash[:notice] = I18n.t('contract.delete')
    redirect_to business_contracts_path(current_business)
  end

  def print
    @customer_address = @contract.customer.customer_addresses.where(primary_address: true).first
    html = render_to_string(layout: false, :template => 'contracts/print.html.haml')
    kit = PDFKit.new(html)
    kit.stylesheets << "#{Rails.root}/vendor/assets/stylesheets/style.css"
    send_data(kit.to_pdf, filename: 'ContractProposal.pdf', type: 'application/pdf')
  end

  private

  def contract_params
    attrs = [:proposal_date, :approx_start_date, :approx_completion_date, :proposal_terms, :addn_provisions, :payment_terms, :completion_date, :advance, :amt, :signed_date, :middle_name, :first_name, :last_name, :start_date, projects_attributes: [:id, :copy_project_id, :of_type, :name, :description, :long_description, :project_category_id, :business_id, :_destroy]]
    attrs << :customer_id if request.post?
    params.require(:contract).permit(attrs)
  end
end
