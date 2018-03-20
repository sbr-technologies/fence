task :add_lookup_defaults => :environment do
  Organization.all.each do |org|
    if org.default_proposal_term.nil?
      org.send(:create_default_proposal_terms)
    end

    org.phone_types.create(description: 'WORK', long_description: 'Description..')
    org.phone_types.create(description: 'HOME', long_description: 'Description..')
    org.phone_types.create(description: 'OTHER', long_description: 'Description..')

    org.unit_of_measurements.create(description: 'EACH', long_description: 'Description..')
    org.unit_of_measurements.create(description: 'DAY', long_description: 'Description..')
    org.unit_of_measurements.create(description: 'YARD', long_description: 'Description..')

    org.project_categories.create(description: 'Landscape', long_description: 'Description..')

    org.product_categories.create(description: 'Material', long_description: 'Description..')
    org.product_categories.create(description: 'Labor', long_description: 'Description..')
    org.product_categories.create(description: 'Rental', long_description: 'Description..')
    org.product_categories.create(description: 'Permit', long_description: 'Description..')
    org.product_categories.create(description: 'OTHER', long_description: 'Description..')

    uom = org.unit_of_measurements.first
    cat = org.product_categories.first
    project_cat = org.project_categories.first

    org.products.all.each do |p|
      if p.unit_of_measurement.nil?
        p.unit_of_measurement = org.unit_of_measurements.first
      else
        if p.unit_of_measurement.organization_id != org.id
          uom = org.unit_of_measurements.find_or_create_by(description: p.unit_of_measurement.description)
          p.unit_of_measurement = uom
        end
      end
      p.save!
      if p.product_category.nil?
        p.product_category = cat 
      else
        if p.product_category.organization_id != org.id
          description = p.product_category.description
          new_category = org.product_categories.find_or_create_by(description: description)
          p.product_category = new_category
        end
      end
      p.save
    end

    org.projects.each do |p|
      if p.project_category.nil?
        p.project_category = project_cat 
      else
        if p.project_category.organization_id != org.id
          description = p.project_category.description
          new_category = org.project_categories.find_or_create_by(description: description)
          p.project_category = new_category
        end
      end
      p.save!
    end

  end

  Phone.all.each do |p|
    org = (p.phonable_type == 'Organization') ? p.phonable : p.phonable.organization 
    if p.phone_type.nil?
      p.phone_type = org.phone_types.first
    else
      if p.phone_type.organization_id != org.id
        new_phone_type = org.phone_types.find_or_create_by(description: p.phone_type.description)
        p.phone_type = new_phone_type
      end
    end
    p.save!
  end

  ProjectProduct.all.each do |p|
    org = p.project.organization
    if p.unit_of_measurement.nil?
      p.unit_of_measurement = org.unit_of_measurements.first
    else
      if p.unit_of_measurement.organization_id != org.id
        uom = org.unit_of_measurements.find_or_create_by(description: p.unit_of_measurement.description)
        p.unit_of_measurement = uom
      end
    end
    p.save!
  end
end
