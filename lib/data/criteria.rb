class Data
  class Criteria
    require_relative 'criteria/hash_proxy'
    require_relative 'criteria/matcher'
    require_relative 'criteria/matcher_factory'
    require_relative 'criteria/version'

    def initialize(opts = {})
      @matchers = {}
      add opts
    end

    def add(opts)
      opts.each do |key, expected|
        matcher = expected.respond_to?(:call) ? expected : MatcherFactory.create(expected)
        add_matcher key, matcher
      end
      self
    end

    def match_all?(hash)
      hash = HashProxy.new(hash)
      @matchers.all? do |key, matchers|
        matchers.all?{|matcher| hash.key?(key) && matcher.call(hash[key]) }
      end
    end

    def match_any?(hash)
      hash = HashProxy.new(hash)
      @matchers.any? do |key, matchers|
        matchers.any?{|matcher| hash.key?(key) && matcher.call(hash[key]) }
      end
    end

    private

    def add_matcher(key, matcher)
      @matchers[key] = @matchers.fetch(key, []).push(matcher)
    end
  end
end
