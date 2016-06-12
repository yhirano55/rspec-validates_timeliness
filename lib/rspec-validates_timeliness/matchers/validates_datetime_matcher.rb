module RSpec::ValidatesTimeliness
  module Matchers
    def validates_datetime(attr_name)
      ValidatesDatetimeMatcher.new(attr_name)
    end

    class ValidatesDatetimeMatcher < ValidationMatcher
      private

      def type
        :datetime
      end
    end
  end
end

