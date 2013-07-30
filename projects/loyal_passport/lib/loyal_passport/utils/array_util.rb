# -*- encoding : utf-8 -*-
module LoyalPassport
  class ArrayUtil
    def self.extract_options!(arr)
      if arr.last.is_a?(Hash)
        arr.pop
      else
        {}
      end
    end

    def self.init args
      args.is_a?(Array) ? args : (args.nil? ? [] : [args])
    end
  end
end
