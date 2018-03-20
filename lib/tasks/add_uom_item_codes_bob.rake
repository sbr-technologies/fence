# bart_f 4-4-16 READ BELOW NOTES:
# e.g. usage rake command to run:  rake app:add_uom_item_codes_bob

namespace :app do
  desc <<-DESC
    Add uom item code values.
    Run using the command 'rake app:add_uom_item_codes_bob'
  DESC
require 'csv'
task :add_uom_item_codes_bob => :environment do
  # Find or create the test business
  org = Business.find_or_create_by(business_name: "Cravinho Landscape & Lighting")

  uom_type_code = LookupTypeCode.find_or_create_by(description: "Unit of Measure")
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Each", business_id: org.id)  
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Yard", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Ton", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Day", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Hour", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Hours", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Unit", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Feet", business_id: org.id) 
  uom = uom_type_code.lookup_item_codes.find_or_create_by(description: "Sq. Feet", business_id: org.id) 

end
end
