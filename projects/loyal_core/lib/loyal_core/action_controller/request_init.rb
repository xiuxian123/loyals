# -*- encoding : utf-8 -*-
module LoyalCore::ActionController
  module RequestInit
    def self.included base
      base.class_eval do
        before_filter do |controller|
          request = controller.send :request

          Rails.logger.debug " -> domain: #{request.domain}"
          Rails.logger.debug " -> subdomain: #{request.subdomain}"
          Rails.logger.debug " -> host: #{request.host}"
          Rails.logger.debug "   * Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
          # I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
          I18n.locale = params[:locale] || I18n.default_locale
          Rails.logger.debug "   * Locale set to '#{I18n.locale}'"

          Rails.logger.debug "   * session: #{session.to_hash}"
        end

        include InstanceMethods
        include ::LoyalCore::ActionController::SeoMethods
      end
    end

    module InstanceMethods

    end
  end
end

if defined?(ActionController::Base)
  ActionController::Base.send :include, ::LoyalCore::ActionController::RequestInit
end
