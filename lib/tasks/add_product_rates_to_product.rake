require 'csv'
task :add_product_rates => :environment do
  Product.all.each do |p|
    if p.product_rates.empty?
      p.product_rates.build(retail_price: 1, cost_price: 1)
      p.save
    end
  end
end

