# -*- encoding : utf-8 -*-
module LoyalCore
  class Ajax::CaptchasController < ::LoyalCore::AjaxController
    def new

      @simple_captcha_options = generate_simple_captcha_options(:object => params[:object])

      respond_to do |format|
        format.html { render :new, :layout => nil }

        format.json {
          render :json => {
            :response => {
              :status => 200,
              :code   => :success
            },
            :simple_captcha_options => @simple_captcha_options 
          }
        }

        format.js   { render :js => "var simpleCaptchaOptions = #{@simple_captcha_options.to_json};" }
      end
    end
  end
end

