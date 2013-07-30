# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::RegistrationsController < ::Devise::RegistrationsController
    include ::LoyalPassport::Controllers::UsersBasic

    def create
      sign_up_params.permit(:nick_name, :permalink, :true_name, :captcha, :captcha_key)

      build_resource(sign_up_params)

      if resource.save_with_captcha
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
    end

    # def create
    #   build_resource

    #   if resource.save_with_captcha
    #     if resource.active_for_authentication?
    #       set_flash_message :notice, :signed_up if is_navigational_format?
    #       sign_in(resource_name, resource)
    #       respond_with resource, :location => after_sign_up_path_for(resource)
    #     else
    #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
    #       expire_session_data_after_sign_in!
    #       respond_with resource, :location => after_inactive_sign_up_path_for(resource)
    #     end
    #   else
    #     clean_up_passwords resource
    #     respond_with resource
    #   end
    # end


    # # GET /resource/cancel
    # # Forces the session data which is usually expired after sign
    # # in to be expired now. This is useful if the user wants to
    # # cancel oauth signing in/up in the middle of the process,
    # # removing all OAuth session data.
    # def cancel
    #   expire_session_data_after_sign_in!
    #   redirect_to new_registration_path(resource_name)
    # end

    # def destroy
    #   if resource.can_cancel_account?
    #     resource.destroy
    #     Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    #     set_flash_message :notice, :destroyed if is_navigational_format?
    #     respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
    #   else
    #     flash[:alert] = I18n.t('loyal_passport.logics.you_cannot_cancel_account')
    #     redirect_to params[:return_to]
    #   end
    # end

  end
end

