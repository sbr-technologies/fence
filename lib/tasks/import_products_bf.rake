require 'csv'
task :prodimport => :environment do
  csv_text = File.read('./products.csv')
  csv = CSV.parse(csv_text, :headers => true)
  biz = Business.find_or_create_by(biz_name: "ConsultingTest")
  pc_mat = biz.product_categories.find_or_create_by(description: "Material")
  pc_lab = biz.product_categories.find_or_create_by(description: "Labor")
  supp = Supplier.find_or_create_by(name: 'United Pipe And Supply Company')
  supp.business_id = biz
  supp.save!
  manuf = Manufacturer.find_or_create_by(name: 'Generic')
  manuf.business_id = biz
  manuf.number = "86"
  manuf.save!
  uom = biz.unit_of_measurements.find_or_create_by(description: 'EACH')
  user = User.find_by(email: "shantinath.roy@sbr-technologies.com")
  csv.each do |row|
    product = Product.new
    row_hash = row.to_hash
    row_hash.each do |key, value|
      if key == "item_id"
        product.product_sku = value
      elsif key == "item_description"
        product.product_name = value
      elsif key == "item_long_description"
        product.product_description = value
      end
    end
    product.preferred_supplier_id = supp.id
    product.manufacturer_id = manuf.id
    product.business_id = biz.id
    if product.product_name.include? "LABOR"
      product.product_category_id = pc_lab.id
    else
      product.product_category_id = pc_mat.id
    end
    product.status_id = biz.statuses.first.id
    product.uom_id = uom.id
    product.save!
  end
end
