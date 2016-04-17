require 'bigdecimal'

class Data
  class Criteria
    class BaseMatcher
      def initialize(expected)
        @expected = expected
      end
      def call(actual)
        raise NotImplementedError, "Define #call method in concrete class"
      end
    end

    class EqMatcher < BaseMatcher
      def call(actual)
        @expected == actual
      end
    end

    class InMatcher < BaseMatcher
      def call(actual)
        @expected.include?(actual)
      end
    end

    class RegexpMatcher < BaseMatcher
      def call(actual)
        !!(@expected =~ actual)
      end
    end

    class NumericComparisonMatcher < BaseMatcher
      REGEXP = /\A\s*([><]=?)\s+([+-]?[0-9]*[\.]?[0-9]+)\s*\z/

      def initialize(expected)
        raise "unsupported format" unless m = REGEXP.match(expected)
        @expected_string = expected
        @op = m[1]
        @expected = BigDecimal(m[2])
      end

      def call(actual)
        case actual
        when String
          actual == @expected_string
        when Numeric
          actual.send(@op.to_sym, @expected)
        else
          raise "actual=#{actual}(#{actual.class}) is unsupported"
        end
      end
    end
  end
end
