task :update_middle_initial => :environment do
  Contact.all.each do |c|
    mi = c.middle_name.nil? ? '' : c.middle_name[0]
    c.update_column(:middle_name, mi)
  end

  User.all.each do |u|
    mi = u.middle_name.nil? ? '' : u.middle_name[0]
    u.update_column(:middle_name, mi)
  end

  Customer.all.each do |c|
    mi = c.middle_name.nil? ? '' : c.middle_name[0]
    c.update_column(:middle_name, mi)
  end

  Contract.all.each do |c|
    mi = c.middle_name.nil? ? '' : c.middle_name[0]
    c.update_column(:middle_name, mi)
  end
end
