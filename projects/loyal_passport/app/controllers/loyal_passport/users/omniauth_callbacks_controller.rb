# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include ::LoyalPassport::Controllers::UsersBasic

    # def github
    #   raise request.env['omniauth.auth'].to_yaml
    # end

    def request_login
      _store_request_information 'login'

      redirect_to user_omniauth_authorize_path(params[:provider])
    end

    def request_bind
      raise "TODO: bind"
    end

    User.omniauth_providers.each do |provider|
      define_method :"#{provider}" do
        Rails.logger.debug request.env['omniauth.auth'].to_yaml
        render :json => request.env['omniauth.auth'].to_json
      end
    end

    private

    # 存储请求 信息
    def _store_request_information usage
      session['loyal_passport.omniauth.return_to'] = params[:return_to]
      session['loyal_passport.omniauth.usage'] = usage
    end
  end
end

