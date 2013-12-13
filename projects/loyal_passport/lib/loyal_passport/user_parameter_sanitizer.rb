# -*- encoding : utf-8 -*-
class ::LoyalPassport::UserParameterSanitizer < Devise::ParameterSanitizer
  # 登录的
  def sign_in
    default_params.permit(*(
      auth_keys + [
        :password,
        :remember_me,
      ]
    ))
  end

  # 注册的
  def sign_up
    default_params.permit(*(auth_keys + [
      :nick_name, :true_name, :captcha, :captcha_key,
      :password, :password_confirmation, :avatar, :avatar_cache, :permalink
    ]))
  end

  # 资料更新
  def account_update
    default_params.permit(*(auth_keys + [
      :password, :password_confirmation, :current_password, :avatar, :avatar_cache
    ]))
  end

end
