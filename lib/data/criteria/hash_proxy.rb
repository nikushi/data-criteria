class Data
  class Criteria
    class HashProxy
      def initialize(hash)
        @hash = hash
      end

      def [](k)
        @hash.fetch(k, nil) || @hash.fetch(k.to_sym, nil) || @hash.fetch(k.to_s, nil) || @hash[k]
      end

      def key?(k)
        @hash.key?(k) || @hash.key?(k.to_sym) || @hash.key?(k.to_s)
      end
    end
  end
end
