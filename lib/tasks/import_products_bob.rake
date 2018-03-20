# bart_f 2-11-16 READ BELOW NOTES:
# e.g. usage rake command to run:  rake app:load_bobs_products

namespace :app do
  desc <<-DESC
    Load product testing data.
    Run using the command 'rake app:load_bobs_products'
  DESC
require 'csv'
task :load_bobs_products => :environment do
  csv_text = File.read('./fenceproductlist-lf.csv')
  csv = CSV.parse(csv_text, :headers => true)

  # Find or create the test business
  org = Business.find_or_create_by(business_name: "Cravinho Landscape & Lighting")
  
  # Find or create the supplier and manufacturer
  supp = Supplier.find_or_create_by(business_name: 'United Pipe And Supply Company', business_id: org.id)
  manuf = Manufacturer.find_or_create_by(business_name: 'Generic', business_id: org.id, business_account_number: '86')

  # Find or create the Products type codes and item codes
  ps_type_code = LookupTypeCode.find_or_create_by(description: "Product Status")
  ps = ps_type_code.lookup_item_codes.find_or_create_by(description: "Active", business_id: org.id)
  uom_type_code = LookupTypeCode.find_or_create_by(description: "Unit of Measure")
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Each", business_id: org.id)  
  pc_type_code = LookupTypeCode.find_or_create_by(description: "Product Category")
  pc_mat = pc_type_code.lookup_item_codes.find_or_create_by(description: "Material", business_id: org.id)
  pc_lab = pc_type_code.lookup_item_codes.find_or_create_by(description: "Labor", business_id: org.id)

  csv.each do |row|
    product = Product.new
    row_hash = row.to_hash
    row_hash.each do |key, value|
      if key == "item_id"
        product.product_sku = value
      elsif key == "item_description"
        product.product_name = value
      elsif key == "item_long_description"
        product.long_description = value
      end
    end
    product.preferred_supplier_id = supp.id
    product.manufacturer_id = manuf.id
    product.business_id = org.id
    product.cost_price = "1.00"
    product.retail_price = "2.00"
  
    # set the appropriate type codes and item codes for each product
    product.category_type_code = pc_type_code.id
    if product.product_name.include? "LABOR"
      product.category_item_code = pc_lab.id     
    else
      product.category_item_code = pc_mat.id  
    end
    product.uom_type_code = uom_type_code.id
    product.uom_item_code = uom.id
    product.status_type_code = ps_type_code.id
    product.status_item_code = ps.id
    product.save!
  end
end
end
