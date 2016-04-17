class Data
  class Criteria
    class Filter
      def initialize(expected)
        @matcher = (
          case expected
          when Array, Range
            InMatcher.new(expected)
          when Regexp
            RegexpMatcher.new(expected)
          when String
            if expected =~ NumericComparisonMatcher::REGEXP
              NumericComparisonMatcher.new(expected)
            else
              EqMatcher.new(expected)
            end
          when Hash
            proc {|obj| Criteria.new(expected).match_all?(obj) }
          else
            EqMatcher.new(expected)
          end
        )
      end

      def call(actual)
        @matcher.call(actual)
      end
    end
  end
end
