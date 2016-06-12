module RSpec::ValidatesTimeliness
  module Matchers
    def validates_time(attr_name)
      ValidatesTimeMatcher.new(attr_name)
    end

    class ValidatesTimeMatcher < ValidationMatcher
      private

      def type
        :time
      end
    end
  end
end

