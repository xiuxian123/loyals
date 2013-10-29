# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :get_loyal_passport_omniauth_login_info, :only => [:login_callback]
    include ::LoyalPassport::Controllers::UsersBasic

    # def github
    #   raise request.env['omniauth.auth'].to_yaml
    # end

    def request_login
      _store_request_information 'login'

      redirect_to user_omniauth_authorize_path(params[:provider])
    end

    def login_callback
      @current_provider_name = ::LoyalPassport::OauthInfo.provider_name_of(params[:provider])

      _return_to = session['loyal_passport.omniauth.return_to']

      # 如果登录着，则将其退出
      user_sign_out if user_signed_in?

      #
      # 如果当前无用户登录，判断是否有其它用户登录
      #   * 有, 切换当前登录的用户
      #   * 无, 提示生成新用户
      #
      if @loyal_passport_omniauth_login_info
        # 登录用户
        if @user = @loyal_passport_omniauth_login_info.login_user
          # 有了登录的用户
          sign_in(:user, @user)
          clear_loyal_passport_omniauth_info_session
          redirect_to (_return_to || loyal_passport_app.users_profile_informations_url), :notice => "通过 #{@current_provider_name} 登录成功！"
        else
          redirect_to new_user_registration_url(:return_to => _return_to)
        end
      else
        redirect_to new_user_session_url(:return_to => _return_to),
          :alert => "从 #{@current_provider_name} 获取登录授权失败，请稍后重试"
      end
    end

    def request_bind
      raise "TODO: bind"
    end

    User.omniauth_providers.each do |provider|
      define_method :"#{provider}" do
        Rails.logger.debug request.env['omniauth.auth'].to_yaml

        info = request.env['omniauth.auth']

        oauth_info = ::LoyalPassport::OauthInfo.save_with_callback_info(provider.to_s, info['uid'], info)

        session['loyal_passport.omniauth.oauth_info_id'] = oauth_info.id

        redirect_to user_omniauth_login_callback_url(provider)
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

