# -*- encoding : utf-8 -*-
module LoyalCore::ActionController
  module SeoMethods
    def self.included base
      base.class_eval do
        helper_method :page_title, :page_keywords, :page_description
        helper_method :page_title_set, :page_keywords_set, :page_description_set

        include InstanceMethods
      end
    end

    module InstanceMethods
      [:title, :keywords, :description].each do |name|
        define_method :"page_#{name}" do
          (@__loyal_core_page_info ||= {})[name]
        end
      end

      def page_title_set title=nil, &block
        if block_given?
          (@__loyal_core_page_info ||= {})[:title] = block.call
        else
          (@__loyal_core_page_info ||= {})[:title] = title
        end
      end

      def page_keywords_set keywords=nil, &block
        if block_given?
          (@__loyal_core_page_info ||= {})[:keywords] = block.call
        else
          (@__loyal_core_page_info ||= {})[:keywords] = keywords
        end
      end

      def page_description_set description=nil, &block
        if block_given?
          (@__loyal_core_page_info ||= {})[:description] = block.call
        else
          (@__loyal_core_page_info ||= {})[:description] = description
        end
      end

    end
  end
end

