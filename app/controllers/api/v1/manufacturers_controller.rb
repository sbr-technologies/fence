module Api
  module V1
    class ManufacturersController < ApplicationController
      protect_from_forgery
      ssl_exceptions
      skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
      load_and_authorize_resource :business
      respond_to :json

      def index
        respond_with current_business.manufacturers
      end
      
      def validate
        if current_business.manufacturers.valid_attribute?(params[:id], params[:field], params[:value]) || params[:value].blank?
          render :json => {:success => true}
        else
          render :json => {:success => false}
        end
      end

      def status_items
        @status_items = current_business.lookup_item_codes.where({:lookup_type_code_id => Supplier.status_type}).select(:id, :description)
        respond_with @status_items
      end
      
            
      def update_field
        @manufacturer = current_business.manufacturers.find(params[:id])
        if @manufacturer.update(manufacturer_params.merge(modified_by))
          render json: @manufacturer
        else
          render json: current_business.manufacturers.find(params[:id])
        end
      end
      
            
      def destroy_multiple
        if !params[:selection].empty?
          params[:selection].each do |p|
            current_business.manufacturers.destroy(p[:id]) rescue ActiveRecord::RecordNotDestroyed
          end
          flash[:notice] = I18n.t('manufacturer.delete_selected')
          render json: {:status => true, :url => business_manufacturers_path(current_business)}
        end
      end
      
      private
      
      def manufacturer_params
        params.require(:manufacturer).permit(:business_account_number, :status_item_code)
      end
    end
  end
end



