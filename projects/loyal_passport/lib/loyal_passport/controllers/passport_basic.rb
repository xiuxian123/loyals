# -*- encoding : utf-8 -*-
module LoyalPassport::Controllers
  # 通行证相关的逻辑，用于用户验证，登录，身份以及权限等
  module PassportBasic
    def self.included(base)
      base.class_eval do
        extend  ClassMethods

        include SharedMethods

        helper  SharedHelperMethods

        include InstanceMethods

        before_filter :impl_loyal_passport_request_init

        rescue_from ::CanCan::AccessDenied do |exception|
          # :redirect_to, 'http://www.ruby800.com', :alert => 'Access Denied'
          # :render, :text => 'Access Denied'
          # redirect_to root_url, :alert => exception.message

          call_params = ::LoyalPassport.config.resuce_cancan_access_denied_call
          case call_params[0]
          when :redirect_to
            redirect_to call_params[1] || "/", call_params[2] || {}
          else #### render and else
            render call_params[1], call_params[2] || {}
          end
        end
      end
    end

    module ClassMethods

    end

    module SharedMethods
      # FIXME: 需要更好的写法
      def loyal_authenticate_admin!
        authenticate_user!
        authorize! :manage, :all
      end

      # 当前用户的ability
      def current_user_ability
        @current_user_ability ||= (current_user || User.new).ability
      end

    end

    module SharedHelperMethods
      def output_user_image_tag user, options={}
        image_tag(user.avatar.url(options[:style] || :tiny))
      end

      # 渲染返回的隐藏域
      def util_output_return_to_hidden_field_tag value=request.referer
        hidden_field_tag :return_to, params[:return_to] || value, :id => nil
      end
    end

    module InstanceMethods

      def impl_loyal_passport_request_init
        if user_signed_in?
          _impl_set_user_signed_in_cookies('1')
        else
          _impl_set_user_signed_in_cookies('-1')
        end
      end

      private

      def _impl_set_user_signed_in_cookies value=nil
        cookies['user_signed_in'] = {
          :value => value,
          :path => '/',
          :domain => request.domain,
          :expires => ::LoyalPassport.config.session_expire_after.to_i.seconds.from_now
        }
      end

    end
  end
end

