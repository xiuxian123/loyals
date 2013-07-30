# -*- encoding : utf-8 -*-
module LoyalCore
  module ActiveModel
    # 用于在校验的时候去除首尾的空格
    module StripWhitespace
      def self.included base
        base.class_eval do
          extend ClassMethods
        end
      end
    end

    module ClassMethods
      def strip_whitespace_before_validation *args
        options = args.extract_options!

        before_validation do |r|
          args.each do |field|
            self.send :"#{field}=", self.send(field).to_s.strip
          end
        end
      end
    end
  end
end


