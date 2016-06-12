module RSpec::ValidatesTimeliness
  module Matchers
    def validates_datetime(attr_name)
      ValidatesDatetimeMatcher.new(attr_name)
    end

    class ValidatesDatetimeMatcher < ValidationMatcher
    end
  end
end

