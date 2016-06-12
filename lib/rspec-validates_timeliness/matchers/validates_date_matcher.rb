module RSpec::ValidatesTimeliness
  module Matchers
    def validates_date(attr_name)
      ValidatesDateMatcher.new(attr_name)
    end

    class ValidatesDateMatcher < ValidationMatcher
    end
  end
end

