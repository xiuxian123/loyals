# -*- encoding : utf-8 -*-
module LoyalSpider
  class HashUtil
    def self.deep_merge!(a_hash, b_hash)
      b_hash.each_pair do |k,v|
        tv = a_hash[k]
        a_hash[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? self.deep_merge(a_hash, v) : v
      end

      a_hash
    end

    def self.deep_merge a_hash, b_hash
      self.deep_merge! self.deep_dup(a_hash), b_hash
    end

    def self.deep_dup hash
      duplicate = hash.dup

      duplicate.each_pair do |k,v|
        tv = duplicate[k]
        duplicate[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? (self.deep_dup(tv)) : v
      end

      duplicate
    end

  end
end
