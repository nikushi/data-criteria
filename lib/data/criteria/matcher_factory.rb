class Data
  class Criteria
    class MatcherFactory
      class << self
        def create(expected)
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
        end
      end
    end
  end
end
