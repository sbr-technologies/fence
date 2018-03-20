module Api
  module V1
    class LookupItemCodesController < ApplicationController
      protect_from_forgery
      ssl_exceptions
      skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
      load_and_authorize_resource :business
      respond_to :json

      def index
#        respond_with current_business.default_proposal_term
      end
      def show
        respond_with current_business.lookup_item_codes.find(params[:id])
      end
    end
  end
end

