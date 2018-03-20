class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name, :name, :middle_initial, :margin_percent, :start_date, :start_date_text, :status_item_code, :status, :can_destroy?
end