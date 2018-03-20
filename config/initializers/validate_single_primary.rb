module ActiveRecord
  class Base
    # Validate that the the objects in +collection+ are unique
    # when compared against all their non-blank +attrs+. If not
    # add +message+ to the base errors.
    def validate_single_primary_in_memory_for(collection)
      collection.inject(0) do |count, record, msg|
        count += 1  if record.send(:is_primary) and !record.marked_for_destruction?
        self.errors.add(:base, I18n.t("activerecord.errors.models.#{record.class.to_s.downcase}.single_primary")) and return if count > 1
        count
      end
    end
  end
end
