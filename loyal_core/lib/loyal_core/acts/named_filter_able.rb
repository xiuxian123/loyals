# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsNamedFilterAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_named_filter_able *args
        options = args.extract_options!

        field_name = args.first
        config = options[:config] || ::LoyalCore::ConfigUtil.new

        # color_named_filter_config
        self.class.send :define_method, :"#{field_name}_named_filter_config" do
          config
        end

        # filter_by_named_color
        scope :"filter_by_named_#{field_name}", ->(*names) do
          where :"#{field_name}" => config.values_at(*names)
        end

        # filter_named_color
        define_method :"filter_named_#{field_name}" do
          config.item(self.send field_name)
        end

        include InstanceMethods
      end

      module InstanceMethods

      end
    end
  end
end
