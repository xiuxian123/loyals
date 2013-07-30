# -*- encoding : utf-8 -*-
module LoyalPassport
  module ControllerExtends
    def self.included(base)
      base.class_eval do
        include InstanceMethods

        before_filter :impl_prepend_loyal_passport_view_paths
      end
    end

    module InstanceMethods

      protected

      def impl_prepend_loyal_passport_view_paths
        (::LoyalPassport.config.prepend_view_paths[request.host] || []).each do |view_path|
          self.prepend_view_path view_path
        end
      end
    end
  end
end

if defined?(ActionController::Base)
  ActionController::Base.send :include, ::LoyalPassport::ControllerExtends
end

