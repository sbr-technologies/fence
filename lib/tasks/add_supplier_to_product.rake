task :add_supplier_to_product => :environment do
  Business.all.each do |biz|
    supplier_id = Supplier.find_or_create_by(name: 'United Pipe And Supply Company', business_id: biz.id)
    biz.products.each do |product|
      product.update_column(:preferred_supplier_id, supplier_id)
    end
  end
end
