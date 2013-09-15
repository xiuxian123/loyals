# -*- encoding : utf-8 -*-
LoyalPassport::Engine.routes.draw do
  constraints lambda {|request| LoyalPassport.config.request_routes_constraints?(request) } do
    devise_for :users, :controllers => {
      :omniauth_callbacks      => "loyal_passport/users/omniauth_callbacks",
      :sessions                => "loyal_passport/users/sessions",
      :unlocks                 => "loyal_passport/users/unlocks",
      :registrations           => "loyal_passport/users/registrations",
      :passwords               => "loyal_passport/users/passwords",
      :confirmations           => "loyal_passport/users/confirmations"
    }

    devise_scope :user do
      namespace :users do
        namespace :profile do
          root :to => "informations#index"
        end

      end

      get "users/auth/:provider/login(.:format)" => 'users/omniauth_callbacks#request_login',
        :as => :user_omniauth_request_login, :provider => ::LoyalPassport::OauthInfo.providers_regexp

      root :to => "users/sessions#new"
    end
  end

  # 管理后台
  constraints lambda {|request| LoyalAdmin.config.request_routes_constraints?(request) } do
    scope :admin, :module => :admin, :as => :admin do
      resources :users, :only => [:index, :show, :edit, :update]

      namespace :loyal_passport do
        resources :roles
        resources :assignments
      end
    end
  end

end
