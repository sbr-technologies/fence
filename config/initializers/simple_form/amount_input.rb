module SimpleForm
  module Components
    module Amount
      def amount(wrapper_options = nil)
        input_html_options[:amount] ||= false
      end

      def amount_options
        {'data-a-dec' => '.', 
         'data-a-sep' => ',', 
         'data-a-sign' => '', 
         'data-v-min' => '0', 
         'data-v-max' => '999999999.99'
        }
      end
    end
  end
end

require 'simple_form/i18n_cache'
require 'active_support/core_ext/string/output_safety'
require 'action_view/helpers'

module SimpleForm
  module Inputs
    class Base
      include SimpleForm::Components::Amount
    end
  end
end
