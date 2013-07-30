# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::UnlocksController < Devise::UnlocksController
    include ::LoyalPassport::Controllers::UsersBasic

  end
end
