class EndAfterStartValidator < ActiveModel::Validator
  def validate(record)
    return if record.end_date.blank? || record.start_date.blank?
    if record.end_date < record.start_date
      record.errors[:end_date] << I18n.t("#{record.class.to_s.downcase}.errors.end_date")
    end
  end
end
