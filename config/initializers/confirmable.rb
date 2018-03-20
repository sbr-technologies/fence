module Devise
  module Models
    module Confirmable
      protected
      def reconfirmation_required?
        self.class.reconfirmable && @reconfirmation_required
      end
    end
  end
end
