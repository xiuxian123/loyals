# -*- encoding : utf-8 -*-
module LoyalPassport::Users::Profile
  class InformationsController < ::DeviseController
    include ::LoyalPassport::Controllers::UsersBasic

    before_filter do |controller|
      controller.send :authenticate_user!, :force => true
    end

    # users/profile/informations
    def index

    end
  end
end

