# -*- encoding : utf-8 -*-
module LoyalPassport::Users::Profile
  class OauthLoginsController < ::DeviseController
    include ::LoyalPassport::Controllers::UsersBasic

    before_filter do |controller|
      controller.send :authenticate_user!, :force => true
    end

    before_action :get_loyal_passport_omniauth_login_info, :only => [:new, :create]
    before_filter :_adjust_jump_when_loyal_passport_omniauth_login_info, :only => [:new, :create]

    def index
      @oauth_logins = current_user.oauth_logins.includes(:oauth_info)
    end

    def new
      @oauth_login = ::LoyalPassport::OauthLogin.new(
        :oauth_info_id => @loyal_passport_omniauth_login_info.id,
        :user_id => current_user.id
      )
    end

    def create
      @oauth_login = ::LoyalPassport::OauthLogin.new(oauth_login_params)

      if @oauth_login.save
        redirect_to (params[:return_to] || loyal_passport_app.users_profile_oauth_logins_url), :notice => "绑定帐号成功！"
      else
        render :new
      end
    end

    def cancel
      clear_loyal_passport_omniauth_info_session

      if params[:return_to].present?
        redirect_to params[:return_to]
      else
        redirect_to loyal_passport_app.users_profile_informations_url
      end
    end

    protected

    def _adjust_jump_when_loyal_passport_omniauth_login_info
      unless util_loyal_passport_omniauth_login_info_present?
        # 清理一下，其它的session
        clear_loyal_passport_omniauth_info_session

        if params[:return_to].present?
          redirect_to params[:return_to]
        else
          redirect_to loyal_passport_app.users_profile_informations_url
        end
      end
    end

    def oauth_login_params
      params[:oauth_login]
    end
  end
end

