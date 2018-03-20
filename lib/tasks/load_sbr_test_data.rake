# bart_f 2-11-16 READ BELOW NOTES:
# Only data not required in production should be here.
# If it needs to be there in production, it belongs in seeds.rb.
# e.g. usage rake command to run:  rake db:drop db:create db:schema:load db:seed app:load_demo_data

namespace :app do
  desc <<-DESC
    Load sbr testing data.
    Run using the command 'rake app:load_sbr_demo_data'
  DESC
  task :load_sbr_demo_data => [:environment] do

	#creates test business 1
	org = Business.find_by(business_name: 'business_name_org_1')
	type_code = LookupTypeCode.find_by(description: "Contract Proposal -Proposal Payment Terms")
    type_code.lookup_item_codes.create!(description: "40/60", long_description: "If the proposal is accepted the owner agrees to pay fence landscape construction the above prices in the following manner: deposit of 60% @ signing the contract & 40% @ start of project. Balance due upon completion.  Owner / Owners Agent signature and Contractor / Agent signature constitutes a legal contract", business_id: org.id)
    type_code = LookupTypeCode.find_by(description: "Contract Proposal -Proposal Terms")
    type_code.lookup_item_codes.create!(description: "Custom", long_description: "FENCE Construction hereby submits this proposal for acceptance by the above names person or entity. This proposal includes all labor, materials, equipment in services to perform the following. All the services behond those specified in this proposal will be billed at an hourly labor and equipment rate plus materials custom....", business_id: org.id)
  end
end

