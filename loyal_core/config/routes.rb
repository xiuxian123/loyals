# -*- encoding : utf-8 -*-
LoyalCore::Engine.routes.draw do

  scope :admin, :module => :admin, :as => :admin, :path => :loyal_core do
    namespace :skin do
      resources :folders
      resources :recipes
    end
  end
  
  namespace :ajax do
    scope :core, :as => :core, :path => :core do
      get "like_tracks/:target_type/:target_id/touch(.:format)"  => "like_tracks#touch",       :as => :touch_like_track
      get "rating_tracks/:target_type/:target_id/up(.:format)"   => "rating_tracks#up",        :as => :up_rating_track
      get "rating_tracks/:target_type/:target_id/down(.:format)" => "rating_tracks#down",      :as => :down_rating_track


      resources :captchas, :only => [:new]

      # ajax_core_login_path
      get "login(.:format)" => "users/sessions#new", :as => :login
    end
  end
end
