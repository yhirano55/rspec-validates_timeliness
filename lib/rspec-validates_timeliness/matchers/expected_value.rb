module RSpec::ValidatesTimeliness
  module Matchers
    class ExpectedValue
      def initialize(value)
        @value = evaluate(value)
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

      def evaluate(value)
        case value
        when Proc then value.call
        when Time, DateTime, Date then value
        when String then value.to_time
        else nil
        end
      end
    end
  end
end
