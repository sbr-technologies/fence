class LookupItemsController < ApplicationController
  ssl_exceptions
  before_action :authenticate_user!
  load_and_authorize_resource :business
  
  def index
    if !params[:selected_option].nil?
      @lookup_items = @business.lookup_item_codes.where(:lookup_type_code_id => params[:selected_option])
      @lookup_type =LookupTypeCode.find(params[:selected_option])
    end
    respond_to do |format|
      format.html
      format.js{render layout: false}
    end
  end
  
  def unique_name
#    look_type_model = params[:model_name].singularize.camelcase.constantize
    lookup_object = @business.lookup_item_codes.find_or_initialize_by(id: params['lookup_object_id'], lookup_type_code_id: params[:lookup_type_object_id])
    lookup_object.description = params['description']
    lookup_object.valid?
    render json: lookup_object.errors[:description].blank?
  end
  

  def destroy
    @lookup_item = @business.lookup_item_codes.find(params[:id])
    type_code = @lookup_item.lookup_type_code_id
    @lookup_item.destroy rescue ActiveRecord::RecordNotDestroyed
    render json: @business.lookup_item_codes.where(:lookup_type_code_id => type_code).as_json(only: [:id, :description, :long_description], methods: [:can_destroy?])
  end
  
  private
  
  def lookup_params
    attrs = [:id, :lookup_type_code_id, :description, :long_description]
    params.require(:lookup_item).permit(attrs)
  end
end