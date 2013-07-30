# -*- encoding : utf-8 -*-
module LoyalCore
  class Ajax::LikeTracksController < ::LoyalCore::AjaxController
    before_filter :authenticate_user!

    def touch
      target_clazz = ::LoyalCore.config.clazz_alias[params[:target_type]]

      result = {}

      if target_clazz && (target_clazz = target_clazz.constantize)
        target = target_clazz.find_by_uuid(params[:target_id])

        _code = target.touch_liked_by!(current_user)

        if target
          result = { 
            :code => _code,
            :count  => target.liked_count
          }
        end
      end

      render :json => {
        :response => {
          :status => 200,
          :code   => :success
        },
        :result => result
      }
    end
  end
end
