module Api
  module V1
    class PgProductsController < ApplicationController
	  protect_from_forgery
	  ssl_exceptions
      skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
      load_and_authorize_resource :business
      #  load_and_authorize_resource :project, through: :business
	  respond_to :json

	  def index
      respond_with current_business.pg_products.where("project_group_id = ?", params['id'])
	  end
    
	  private

    end
  end
end

#project_products_attributes => [:id, :product_id, :name, :quantity, :labor_hour, :labor, :status, :_destroy, :unit_of_measurement_id, :retail_price]
