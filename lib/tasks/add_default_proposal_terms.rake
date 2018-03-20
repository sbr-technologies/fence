task :add_default_proposal_terms => :environment do
  new_org = Organization.new
  Organization.all.each do |org|
    if org.default_proposal_term.nil?
      org.send(:create_default_proposal_terms)
    end
  end
end

