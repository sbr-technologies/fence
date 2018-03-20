task :add_manufacturer_to_product => :environment do
  Business.all.each do |biz|
    manufacturer_id = Manufacturer.find_or_create_by(name: 'JM eagle', number:1, business_id: biz.id)
    biz.products.each do |product|
      product.update_column(:manufacturer_id, manufacturer_id)
    end
  end
end
