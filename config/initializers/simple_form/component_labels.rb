module SimpleForm
  module Components
    module Labels
      extend ActiveSupport::Concern

      protected

      def label_translation #:nodoc:
        if SimpleForm.translate_labels && (translated_label = translate_from_namespace(:labels))
          translated_label
        elsif object.class.respond_to?(:human_attribute_name)
          object.class.human_attribute_name(reflection_or_attribute_name.to_s).titleize
        else
          attribute_name.to_s.humanize
        end
      end
    end
  end
end
