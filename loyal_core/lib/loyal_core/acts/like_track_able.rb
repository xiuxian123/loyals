# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsLikeTrackAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_like_track_able *args
        has_many :like_tracks, :class_name => "LoyalCore::LikeTrack", :as => :target

        include InstanceMethods

        scope :filter_by_liked_by, ->(user_or_user_id) do
          joins(:like_tracks).where(
            :"#{::LoyalCore::LikeTrack.table_name}" => {
              :created_by => (user_or_user_id.is_a?(User) ? user_or_user_id.id : user_or_user_id)
            }
          )
        end
      end

      module InstanceMethods
        def user_like_tracks user
          self.like_tracks.filter_by_creator user
        end

        # 是否被 ** 喜欢了?
        def liked_by? user
          return false if user.nil?

          ::TinyCache.cache_store.fetch liked_cache_key(:user_id => user.id) do
            self.user_like_tracks(user).exists?
          end
        end

        # 被**喜欢
        def liked_by! user, options={}
          tmp_scope = self.user_like_tracks(user)
          tmp_scope.create

          self.reload

          self.touch

          _expire_liked_cache :user_id => user.id
        end

        # 取消喜欢
        def undo_liked_by! user
          self.user_like_tracks(user).destroy_all

          self.reload

          self.touch

          _expire_liked_cache :user_id => user.id
        end

        # return:
        #   :like
        #   :undo
        def touch_liked_by! user
          if self.liked_by?(user)
            self.undo_liked_by!(user)
            :undo
          else
            self.liked_by!(user)
            :like
          end
        end

        private

        # 使过期
        def _expire_liked_cache options={}
          # 刷新更新时间

          ::TinyCache.cache_store.delete liked_cache_key(options)
        end

        def liked_cache_key options={}
          "#{::TinyCache.cache_key_prefix}/ables/like_track_able/#{self.class.name}/#{self.id}/userid:#{options[:user_id]}"
        end
      end
    end
  end
end
