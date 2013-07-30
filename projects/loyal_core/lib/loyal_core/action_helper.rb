# -*- encoding : utf-8 -*-
require "#{File.dirname(__FILE__)}/action_helper/ajax/like_tracks_helper"
require "#{File.dirname(__FILE__)}/action_helper/ajax/rating_tracks_helper"
require "#{File.dirname(__FILE__)}/action_helper/font_selector_helper"

module LoyalCore
  module ActionHelper
    include ::LoyalCore::Ajax::RatingTracksHelper
    include ::LoyalCore::Ajax::LikeTracksHelper
    include ::LoyalCore::FontSelectorHelper

    


    def render_new_simple_captcha_partial options={}
      render :partial => '/loyal_core/ajax/captchas/new', :locals => {
        :options => generate_simple_captcha_options(options)
      }
    end

  end
end

if defined?(ActionController::Base)
  ActionController::Base.send :helper, ::LoyalCore::ActionHelper
end

