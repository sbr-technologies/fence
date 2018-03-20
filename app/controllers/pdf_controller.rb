class PdfController < ApplicationController
  ssl_allowed :all

  def header
    @business = Business.find params[:business_id]
    @address = @business.address
    @phone = @business.phones.where(is_primary: true)
    if @phone.present?
      @phone = @phone.first
    else
      @phone = @business.phones.first
    end
    render layout: false
  end

  def name
    @business = Business.find params[:business_id]
    render layout: false
  end

  def footer
    @business = Business.find params[:business_id]
    render layout: false
  end
end
