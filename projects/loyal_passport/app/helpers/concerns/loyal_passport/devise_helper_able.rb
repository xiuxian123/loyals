module Concerns
  module LoyalPassport
    module DeviseHelperAble
      include ::DeviseHelper

      def loyal_passport_omniauth_login?
        session['loyal_passport.omniauth.usage'] == 'login' && session['loyal_passport.omniauth.oauth_info_id'].present?
      end

    end
  end
end
