class ManufacturerSerializer < ActiveModel::Serializer
  attributes :id, :name, :business_account_number, :status_item_code, :status, :can_destroy?
end