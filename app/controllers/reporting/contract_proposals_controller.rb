class Reporting::ContractProposalsController < ApplicationController
  ssl_exceptions [:print_list]
  before_action :authenticate_user!
  load_and_authorize_resource :business
#  load_and_authorize_resource :contract_proposal, through: :business

  def show
    @contract_proposal = @business.contract_proposals.find(params[:id])
    @address = @business.address
    @phone = @business.phones.where(is_primary: true)
    if @phone.present?
      @phone = @phone.first
    else
      @phone = @business.phones.first
    end
    @contact = @business.contact_persons.first
    
    render layout: false
  end
  
  def print_list
    contracts = JSON.parse(params[:contract_ids]);
    @contract_proposals = ContractProposal.find(contracts)
    #    render :text => @projects.inspect
    html = render_to_string(layout: false, :template => 'reporting/contract_proposals/print_list.html.haml')
    #    kit = PDFKit.new(html, :header => name_business_pdf_index_url(@business))
    kit = PDFKit.new(html, :footer_center => "Page [page] of [toPage]")
    kit.stylesheets << "#{Rails.root}/vendor/assets/stylesheets/proposal_list.css"
    send_data(kit.to_pdf, filename: "proposals_report.pdf", type: 'application/pdf')
  end
  
  def print_details
    contracts = JSON.parse(params[:contract_ids]);
    @contract_proposals = ContractProposal.find(contracts)
    #    render :text => @projects.inspect
    @address = @business.address
    @phone = @business.phones.where(is_primary: true)
    if @phone.present?
      @phone = @phone.first
    else
      @phone = @business.phones.first
    end
    @contact = @business.contact_persons.first
    html = render_to_string(layout: false, :template => 'reporting/contract_proposals/print_details.html.haml')
    #    kit = PDFKit.new(html, :header => name_business_pdf_index_url(@business))
    kit = PDFKit.new(html, :footer_center => "Page [page] of [toPage]")
    kit.stylesheets << "#{Rails.root}/vendor/assets/stylesheets/proposal_details.css"
    send_data(kit.to_pdf, filename: "proposals_detail_report.pdf", type: 'application/pdf')
  end
end
