module SimpleForm
  module Inputs
    class NumericInput < Base
      enable :placeholder, :min_max, :amount

      def input(wrapper_options = nil)
        if input_html_classes.include? :amount
          input_html_options['data-a-dec'] = '.'
          input_html_options['data-a-sep'] = ','
          input_html_options['data-a-sign'] = ''
          input_html_options['data-v-min'] = '0'
          input_html_options['data-v-max'] = '999999999.99'
          input_html_classes.delete(:float)
          input_html_classes << :required
          p '#################'
          p input_html_classes
        else
          input_html_classes.unshift('numeric')
          if html5?
            input_html_options[:type] ||= "number"
            input_html_options[:step] ||= integer? ? 1 : "any"
            input_html_options[:min] ||= 0
          end
        end
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
        @builder.text_field(attribute_name, merged_input_options)
      end
    end
  end
end
