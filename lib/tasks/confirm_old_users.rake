task :confirm_old_users => :environment do
  Organization.all.each do |org|
    org.employees.each do |e|
      unless e.confirmed?
        e.confirm!
      end
    end
  end
end
