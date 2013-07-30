# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::ConfirmationsController < ::Devise::ConfirmationsController
    include ::LoyalPassport::Controllers::UsersBasic
  end
end
