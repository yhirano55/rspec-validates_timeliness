module RSpec::ValidatesTimeliness
  module Matchers
    class ValidatorProxy
      def initialize(model, attr_name)
        @model = model
        @attr_name = attr_name
      end

      def valid?(value)
        set_value(value)
        validate!
        error_message.blank?
      end

      def invalid?(value)
        !valid?(value)
      end

      private

      attr_reader :model, :attr_name

      def set_value(value)
        model.instance_variable_set(:"@#{attr_name}", value)
      end

      def validate!
        model.validate
      end

      def error_message
        model.errors.messages[attr_name]
      end
    end
  end
end
