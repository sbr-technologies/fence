class PgProductSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :product_name, :quantity, :uom_item_code, :labor_hours, :labor_cost
  
  def product_name
    Product.find(object.product_id).product_name
  end
end
