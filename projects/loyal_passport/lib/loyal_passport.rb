# -*- encoding : utf-8 -*-
require 'loyal_passport/utils'
require "loyal_passport/engine"
require "loyal_passport/config"
require "loyal_passport/acts"

require "loyal_passport/controllers/controller_extends"

module LoyalPassport
  module Controllers
    autoload :DeviseExtends,      'loyal_passport/controllers/devise_extends'
    autoload :PassportBasic,      'loyal_passport/controllers/passport_basic'
    autoload :CustomFailureApp,   'loyal_passport/controllers/custom_failure_app'
    autoload :UsersBasic,         'loyal_passport/controllers/users_basic'
  end

  autoload :DeviseHelper,         'loyal_passport/devise_helper'
  autoload :UtilHelper,           'loyal_passport/util_helper'

  autoload :UserParameterSanitizer, 'loyal_passport/user_parameter_sanitizer'
end

I18n.load_path += Dir[Pathname.new(__FILE__).join('..', '..', 'config', 'locales', '**', '*.{rb,yml}').to_s]

if defined?(::ActionController::Base)
  ::ActionController::Base.send :include, ::LoyalPassport::Controllers::PassportBasic
end

