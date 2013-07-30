# -*- encoding : utf-8 -*-
module LoyalCore
  class Ajax::RatingTracksController < ::LoyalCore::AjaxController
    before_filter :authenticate_user!

    def up
      down_or_up :up
    end

    def down
      down_or_up :down
    end

    def down_or_up(action)
      target_clazz = ::LoyalCore.config.clazz_alias[params[:target_type]]

      result = {}

      if target_clazz && (target_clazz = target_clazz.constantize)
        target = target_clazz.find_by_uuid(params[:target_id])

        if target
          result = { 
            :code        => target.send(:"#{action}_rating_by!", current_user),
            :action      => action,
            :up_rating   => target.up_rating,
            :down_rating => target.down_rating
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
