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

      def require_no_authentication_no_alert
        assert_is_devise_resource!
        return unless is_navigational_format?
        no_input = devise_mapping.no_input_strategies

        authenticated = if no_input.present?
                          args = no_input.dup.push :scope => resource_name
                          warden.authenticate?(*args)
                        else
                          warden.authenticated?(resource_name)
                        end

        if authenticated && resource = warden.user(resource_name)
          redirect_to after_sign_in_path_for(resource)
        end
      end

      protected

      def devise_parameter_sanitizer
        if resource_class == ::User
          ::LoyalPassport::UserParameterSanitizer.new(::User, :user, params)
        else
          super # Use the default one
        end
      end
    end
  end
end

