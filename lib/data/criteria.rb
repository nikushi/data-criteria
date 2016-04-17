class Data
  class Criteria
    require_relative 'criteria/filter'
    require_relative 'criteria/hash_proxy'
    require_relative 'criteria/matcher'
    require_relative 'criteria/version'

    def initialize(opts = {})
      @filters = {}
      add opts
    end

    def add(opts)
      opts.each do |key, expected|
        filter = expected.respond_to?(:call) ? expected : Filter.new(expected)
        add_filter key, filter
      end
      self
    end

    def match_all?(hash)
      hash = HashProxy.new(hash)
      @filters.all? do |key, filters|
        filters.all?{|filter| hash.key?(key) && filter.call(hash[key]) }
      end
    end

    private

    def add_filter(key, filter)
      @filters[key] = @filters.fetch(key, []).push(filter)
    end
  end
end
