# -*- encoding : utf-8 -*-
module LoyalCore
  module ActiveModel
    module HumanDisplayAble
      def self.included base
        base.class_eval do
          extend ClassMethods
          include InstanceMethods
        end
      end

      module ClassMethods
        def human_name
          self.model_name.human
        end
      end

      module InstanceMethods
        def class_human_name
          self.class.human_name
        end
      end
    end
  end
end

