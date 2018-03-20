task :update_amount => :environment do
  ProductRate.all.each do |rate|
    if rate.retail_price == 0
      rate.retail_price = 1000
    elsif rate.retail_price < 2   
      rate.retail_price = rate.retail_price * 1000 
    end
    rate.cost_price = rate.cost_price * 1000 if rate.cost_price < 2
    rate.save
  end

  ProjectProduct.all.each do |pp|
    pp.labor_rate = pp.labor_rate * 100 if pp.labor_rate < 100
    pp.total_price = pp.retail_price.to_i * pp.quantity
    pp.total_amount = pp.total_price + (pp.labor_rate * pp.labor_hour)
    pp.save
  end

  Project.all.each do |p|
    p.send(:calculate_amount)
  end

  Contract.all.each do |contract|
    contract.amt = contract.projects.sum(:amount).to_f/100
    contract.save
  end
end
