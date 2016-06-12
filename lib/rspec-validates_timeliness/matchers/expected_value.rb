module RSpec::ValidatesTimeliness
  module Matchers
    class ExpectedValue
      def initialize(value, type)
        @value = evaluate(value, type)
      end

      def equal
        @equal ||= value
      end

      def over
        case value
        when Time, DateTime
          value + 1.second
        when Date
          value + 1.day
        end
      end

      def under
        case value
        when Time, DateTime
          value - 1.second
        when Date
          value - 1.day
        end
      end

      private

      attr_reader :value

      def evaluate(value, type)
        case value
        when Proc
          value.call.try("to_#{type}")
        when Time, DateTime, Date, String
          value.try("to_#{type}")
        else nil
        end
      end
    end
  end
end
