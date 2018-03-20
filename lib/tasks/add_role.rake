task :add_role => :environment do
  Role.create name: 'Enterprise Admin', level: 1
end
