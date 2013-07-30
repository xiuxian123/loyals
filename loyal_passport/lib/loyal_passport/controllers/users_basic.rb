# -*- encoding : utf-8 -*-
module LoyalPassport::Controllers
  module UsersBasic
    def self.included(base)
      base.class_eval do
        include InstanceMethods
        include ::LoyalPassport::Controllers::DeviseExtends

        before_filter :init_loyal_passport_request

        layout 'loyal_passport/application'

      end
    end

    module InstanceMethods
      def init_loyal_passport_request

      end

      protected

      def devise_parameter_sanitizer
        if resource_class == ::User
          ::LoyalPassport::User::ParameterSanitizer.new(::User, :user, params)
        else
          super # Use the default one
        end
      end
    end
  end
end

