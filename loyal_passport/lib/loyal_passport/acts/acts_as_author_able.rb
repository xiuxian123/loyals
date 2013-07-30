# -*- encoding : utf-8 -*-

module LoyalPassport
  module ActsAsAuthorAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_passport_acts_as_creator_able *args
        belongs_to :creator, :class_name => "User", :foreign_key => :created_by

        scope :filter_by_creator, ->(user_or_user_id) do
          where :created_by => (user_or_user_id.is_a?(::User) ? user_or_user_id.id : user_or_user_id)
        end

        define_method :creator_is? do |__user|
          self.created_by == __user.id
        end
      end
    end
  end
end

