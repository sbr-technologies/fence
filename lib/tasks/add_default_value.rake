task :add_default_value => :environment do
  new_org = Organization.new
  Organization.all.each do |org|
    org.default_proposal_terms = new_org.default_proposal_terms if org.default_proposal_terms.blank?
    org.default_payment_terms = new_org.default_payment_terms if org.default_payment_terms.blank?
    org.default_addn_provisions = new_org.default_addn_provisions if org.default_addn_provisions.blank?
    org.save
  end
end

