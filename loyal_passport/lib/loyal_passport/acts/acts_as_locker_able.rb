# -*- encoding : utf-8 -*-

module LoyalPassport
  module ActsAsLockerAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_passport_acts_as_locker_able *args
        has_many :lockers, :class_name => "LoyalPassport::Locker", :as => :target,
          :dependent => :destroy

        include ActsAsLockerAbleInstanceMethods
      end

      module ActsAsLockerAbleInstanceMethods

      end
    end
  end
end


