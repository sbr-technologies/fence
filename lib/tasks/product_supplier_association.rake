task :association => :environment do
  suppliers = Supplier.where(business_id: nil)

  suppliers.each do |supp|
    supp.products.each do |prod|
      org = Organization.find(prod.business_id)
      prod.supplier = org.suppliers.first
      prod.save
    end
    supp.destroy
  end
end
