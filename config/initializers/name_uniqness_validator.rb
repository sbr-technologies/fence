class NameUniquenessValidator < ActiveModel::Validator
  def validate(record)
    relation = record.class.where("business_id =?", record.business_id)
    relation = relation.where("lower(first_name) =? and lower(last_name) =? ", record.first_name.to_s.downcase, record.last_name.to_s.downcase)
    relation = relation.where("id !=?", record.id) if record.id
    if relation.present?
      record.errors[:first_name] << I18n.t("#{record.class.to_s.downcase}.errors.name_uniqueness")
    end
  end
end
