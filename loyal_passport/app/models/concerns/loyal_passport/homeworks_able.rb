# -*- encoding : utf-8 -*-
# include Concerns::LoyalPassport::HomeworksAble
module Concerns
  module LoyalPassport
    module HomeworksAble
      def self.included base
        base.class_eval do
          include InstanceMethods

          extend ::LoyalCore::Memoist

          memoize :homework?, :unhomework?, :homeworks_array
        end
      end

      module InstanceMethods

        def homework? job_name, name
          !(unhomework? job_name, name)
        end

        def homeworks_array
          self.homeworks.to_a
        end

        def unhomework? job_name, name
          self.homeworks_array.find { |homework|
            homework.job_name == job_name.to_s &&
              homework.name == name.to_s
          }.nil?
        end

      end
    end
  end
end
