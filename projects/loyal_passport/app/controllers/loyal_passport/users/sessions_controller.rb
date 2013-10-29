# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::SessionsController < Devise::SessionsController
    include ::LoyalPassport::Controllers::UsersBasic

    before_action :get_loyal_passport_omniauth_login_info, :only => [:new, :create]

    def new
      self.resource = resource_class.new(sign_in_params)
      self.resource.remember_me ||= true
      clean_up_passwords(resource)
      respond_with(resource, serialize_options(resource))
    end

    def require_no_authentication
      case params[:action]
      when 'new'
        require_no_authentication_no_alert
      else
        super
      end
    end

    def create
      resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)

      adjust_jump_when_loyal_passport_omniauth_login_info!

      # if util_loyal_passport_omniauth_login_info_present?
      #   redirect_to loyal_passport_app.new_users_profile_oauth_login_url(:return_to => params[:return_to])
      # else
      #   respond_with resource, :location => after_sign_in_path_for(resource)
      # end
    end

    # DELETE /resource/sign_out
    def destroy
      redirect_path = after_sign_out_path_for(resource_name)
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message :notice, :signed_out if signed_out

      # We actually need to hardcode this as Rails default responder doesn't
      # support returning empty response on GET request
      respond_to do |format|
        format.any(*navigational_formats) { redirect_to (params[:return_to] || redirect_path) }
        format.all do
          head :no_content
        end
      end
    end
  end
end

# class Devise::SessionsController < DeviseController
#   prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
#   prepend_before_filter :allow_params_authentication!, :only => :create
#   prepend_before_filter { request.env["devise.skip_timeout"] = true }
# 
#   # GET /resource/sign_in
#   def new
#     resource = build_resource(nil, :unsafe => true)
#     clean_up_passwords(resource)
#     respond_with(resource, serialize_options(resource))
#   end
# 
#   # POST /resource/sign_in
#   def create
#     resource = warden.authenticate!(auth_options)
#     set_flash_message(:notice, :signed_in) if is_navigational_format?
#     sign_in(resource_name, resource)
#     respond_with resource, :location => after_sign_in_path_for(resource)
#   end
# 
#   # DELETE /resource/sign_out
#   def destroy
#     redirect_path = after_sign_out_path_for(resource_name)
#     signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
#     set_flash_message :notice, :signed_out if signed_out
# 
#     # We actually need to hardcode this as Rails default responder doesn't
#     # support returning empty response on GET request
#     respond_to do |format|
#       format.any(*navigational_formats) { redirect_to redirect_path }
#       format.all do
#         head :no_content
#       end
#     end
#   end
# 
#   protected
# 
#   def serialize_options(resource)
#     methods = resource_class.authentication_keys.dup
#     methods = methods.keys if methods.is_a?(Hash)
#     methods << :password if resource.respond_to?(:password)
#     { :methods => methods, :only => [:password] }
#   end
# 
#   def auth_options
#     { :scope => resource_name, :recall => "#{controller_path}#new" }
#   end
# end
# 
