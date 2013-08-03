# -*- encoding : utf-8 -*-
LoyalAdmin::Engine.routes.draw do

  constraints lambda {|request| LoyalAdmin.config.request_routes_constraints?(request) } do
    root :to => 'welcome#index'

    scope :loyal_admin, :path => :loyal_admin do
      namespace :loyal_core do
        namespace :skin do
          resources :folders
          resources :recipes
        end
      end

      namespace :display do
        resources :recipes
        resources :boards
      end
    end
  end
end
