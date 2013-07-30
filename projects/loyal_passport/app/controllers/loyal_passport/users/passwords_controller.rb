# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::PasswordsController < Devise::PasswordsController
    include ::LoyalPassport::Controllers::UsersBasic

  end
end

