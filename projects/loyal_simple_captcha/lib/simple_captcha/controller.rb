# -*- encoding : utf-8 -*-
module SimpleCaptcha #:nodoc 
  module ControllerHelpers #:nodoc
    def self.included base
      base.class_eval do
        include InstanceMethods
        helper_method :generate_simple_captcha_options
      end
    end

    module InstanceMethods
      # This method is to validate the simple captcha in controller.
      # It means when the captcha is controller based i.e. :object has not been passed to the method show_simple_captcha.
      #
      # *Example*
      #
      # If you want to save an object say @user only if the captcha is validated then do like this in action...
      #
      #  if simple_captcha_valid?
      #   @user.save
      #  else
      #   flash[:notice] = "captcha did not match"
      #   redirect_to :action => "myaction"
      #  end
      def simple_captcha_valid?
        return true if Rails.env.test?

        if params[:captcha]
          data = SimpleCaptcha::Utils::simple_captcha_value(params[:captcha_key] || session[:captcha])
          result = data == params[:captcha].delete(" ").upcase
          SimpleCaptcha::Utils::simple_captcha_passed!(session[:captcha]) if result
          return result
        else
          return false
        end
      end

      # 生成验证的信息
      # options:
      #   - object
      def generate_simple_captcha_options *args
        options = args.extract_options!

        key = SimpleCaptcha::Utils.generate_key_use_session(
          session, options[:object]
        )

        {
          :image_url   => ::SimpleCaptcha::Utils.generate_image_url(key, request.base_url, options),
          :label       => options[:label] || I18n.t('simple_captcha.label'),
          :captcha_key => ::SimpleCaptcha::Utils.set_simple_captcha_data(key, options),
          :object      => options[:object]
        }

      end
    end
  end
end
