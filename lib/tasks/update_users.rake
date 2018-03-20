task :update_users => :environment do
  User.all.each do |user|
    if user.email.present?
      user.update_attribute(:need_login, true)
    end
  end
end

