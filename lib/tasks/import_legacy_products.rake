require 'csv'
task :import => :environment do
  csv_text = File.read('./products.csv')
  csv = CSV.parse(csv_text, :headers => true)
  org = Organization.find_or_create_by(business_name: "business_name_org_1")
  pc_mat = org.product_categories.find_or_create_by(description: "Material")
  pc_lab = org.product_categories.find_or_create_by(description: "Labor")
  supp = org.suppliers.find_or_create_by(name: 'B.C. Landscape Construction')
  manufacturer = org.manufacturers.find_or_create_by(name: 'JM eagle')
  uom = org.unit_of_measurements.find_or_create_by(description: 'EACH')
  user = User.find_by(email: "test@org1.com")
  csv.each do |row|
    product = Product.new
    row_hash = row.to_hash
    row_hash.each do |key, value|
      if key == "item_id"
        product.sku = value
      elsif key == "item_description"
        product.name = value
      elsif key == "item_long_description"
        product.long_description = value
      end
    end
    product.supplier_id = supp.id
    product.manufacturer = manufacturer
    product.organization_id = org.id
    if product.name.include? "LABOR"
      product.product_category_id = pc_lab.id
    else
      product.product_category_id = pc_mat.id
    end
    product.status = "Active"
    product.unit_of_measurement = uom
    product.product_rates.build
    product.save!
  end
end
