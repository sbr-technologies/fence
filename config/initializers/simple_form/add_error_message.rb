module SimpleForm
  module Inputs
    class Base
      private
      def html_options_for(namespace, css_classes)
        html_options = options[:"#{namespace}_html"]
        html_options = html_options ? html_options.dup : {}
        css_classes << html_options[:class] if html_options.key?(:class)
        html_options[:class] = css_classes unless css_classes.empty?
        if html_options[:class].include? :required
          model_name = object_name.to_s.parameterize
                                  .underscore
                                  .gsub(/_\d/, '')
                                  .gsub(/_new_([a-z]*_)?[a-z]*/, '')
                                  .gsub('_attributes', '')
                                  .gsub('_new_', '_')
          html_options['data-attr-name'] = I18n.t("errors.#{model_name}.#{@attribute_name}")
        end
        html_options
      end
    end
  end
end
