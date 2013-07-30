# -*- encoding : utf-8 -*-
module LoyalPassport
  class ApplicationController < ::ApplicationController
    layout 'loyal_passport/application'

    include ::LoyalPassport::Controllers::UsersBasic

  end
end
