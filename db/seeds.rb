#bart_f seeds rewrite 2-11-16
#rake command to run:  rake db:drop db:create db:schema:load db:seed 
# bart_f 2-11-16 READ BELOW NOTES:
# Only data required in production should be here.
# All test data should be loaded through model classes (or using factory_girl or similar) in a ‘rake’ file, for example /lib/tasks/test_data.rake and then load it using the rake task rake app:load_demo_data.

LookupTypeCode.create(
	  [
	    { description: "Address Status", long_description: "Address Status" },
	    { description: "Address Type", long_description: "Address Type" },
	    { description: "Business Contact Status Type", long_description: "Business Contact Status Type" },
	    { description: "Business Contact Type", long_description: "Business Contact Type" },
		{ description: "Business End Reason", long_description: "Business End Reason" },
		{ description: "Business Phone Status", long_description: "Business Phone Status" },
		{ description: "Business Status", long_description: "Business Status" },
		{ description: "Contract Proposal -Proposal Payment Terms", long_description: "Contract Proposal -Proposal Payment Terms" },
		{ description: "Contract Proposal -Proposal Terms", long_description: "Contract Proposal -Proposal Terms" },
		{ description: "Customer Contact Status", long_description: "Customer Contact Status" },
		{ description: "Customer Contact Type", long_description: "Customer Contact Type" },		
    { description: "Customer End Reason", long_description: "Customer End Reason" },		
    { description: "Customer Status", long_description: "Customer Status" },		
    { description: "Email Type", long_description: "Email Type" },		
    { description: "Employee End Reason", long_description: "Employee End Reason" },		
    { description: "Employee Status", long_description: "Employee Status" },
		{ description: "Employee Type", long_description: "Employee Type" },		
    { description: "Manufacturer End Reason", long_description: "Manufacturer End Reason" },		
    { description: "Manufacturer Contact Status", long_description: "Manufacturer Contact Status" },		
    { description: "Manufacturer Contact Type", long_description: "Manufacturer Contact Type" },		
    { description: "Manufacturer Status", long_description: "Manufacturer Status" },		
    { description: "Phone Status", long_description: "Phone Status" },		
    { description: "Phone Type", long_description: "Phone Type" },		
    { description: "Product Category", long_description: "Product Category" },		
    { description: "Product Status", long_description: "Product Status" },		
    { description: "Project Category", long_description: "Project Category" },		
    { description: "Project Group Product Status", long_description: "Project Group Product Status" },		
    { description: "Project Group Status", long_description: "Project Group Status" },		
    { description: "Proposal Project Group Product Status", long_description: "Proposal Project Group Product Status" },
		{ description: "Proposal Project Group Status", long_description: "Proposal Project Group Status" },		
    { description: "Proposal Status", long_description: "Proposal Status" },
		{ description: "Supplier Contact Status", long_description: "Supplier Contact Status" },		
    { description: "Supplier Contact Type", long_description: "Supplier Contact Type" },		
    { description: "Supplier End Reason", long_description: "Supplier End Reason" },		
    { description: "Supplier Status", long_description: "Supplier Status" },
		{ description: "Unit of Measure", long_description: "Unit of Measure" },		
    { description: "User End Reason", long_description: "User End Reason" },		
    { description: "User Status", long_description: "User Status" }						
	  ]
	)	
