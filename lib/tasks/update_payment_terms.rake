task :update_payment_terms => :environment do
  new_text = "<p>&nbsp;</p><p>_________ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; _________________________________________________</p><p>&nbsp; &nbsp; Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Owner / Owners Agent signature constitutes a legal contract</p><p>&nbsp;</p><p>_________ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; _________________________________________________</p><p>&nbsp; &nbsp; Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Contractor / Agent signature constitutes a legal contract</p>"
=begin
  Organization.all.each do |org|
    term = org.default_proposal_term
    term.payment_terms = term.payment_terms + new_text
    term.save
  end
=end

  Contract.all.each do |c|
    c.payment_terms = c.payment_terms + new_text
    c.save
  end
end
