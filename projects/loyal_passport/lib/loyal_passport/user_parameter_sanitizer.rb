# -*- encoding : utf-8 -*-
class ::LoyalPassport::UserParameterSanitizer < Devise::ParameterSanitizer
  def sign_in
    default_params.permit(*(
      auth_keys + [
        :password,
        :remember_me,
      ]
    ))
  end

  def sign_up
    default_params.permit(*(auth_keys + [
      :nick_name, :permalink, :true_name, :captcha, :captcha_key,
      :password, :password_confirmation, :avatar, :avatar_cache
    ]))
  end

  def account_update
    default_params.permit(*(auth_keys + [
      :password, :password_confirmation, :current_password, :avatar, :avatar_cache
    ]))
  end

end
