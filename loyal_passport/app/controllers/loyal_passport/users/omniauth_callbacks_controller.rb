# -*- encoding : utf-8 -*-
module LoyalPassport
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include ::LoyalPassport::Controllers::UsersBasic

    # def github
    #   raise request.env['omniauth.auth'].to_yaml
    # end

    [:github, :qq_connect].each do |provider|
      define_method :"#{provider}" do
        raise request.env['omniauth.auth'].to_yaml
      end
    end
  end
end

