task :add_default_phone_type => :environment do
  Organization.all.each do |org|
    org.phone_types.create(name: 'WORK', description: 'Description..')
    org.phone_types.create(name: 'HOME', description: 'Description..')
    org.phone_types.create(name: 'OTHER', description: 'Description..')
  end
end
