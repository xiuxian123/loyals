# -*- encoding : utf-8 -*-
module LoyalPassport::Controllers
  ### devise 扩展 #####################################
  module DeviseExtends
    # 登录完成后跳转的页面
    def after_sign_in_path_for(resource)
      if params[:return_to].present?
        params[:return_to]
      else
        loyal_passport_app.users_profile_root_url
      end

    end

    #### 更新完
    def after_update_path_for(resource)
      if params[:return_to].present?
        params[:return_to]
      else
        loyal_passport_app.users_profile_root_url
      end

    end
  end
end

