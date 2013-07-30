# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsRatingTrackAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_rating_track_able *args
        has_many :rating_tracks, :class_name => "LoyalCore::RatingTrack", :as => :target

        include InstanceMethods
      end

      module InstanceMethods
        def user_rating_tracks user
          self.rating_tracks.filter_by_creator(user)
        end

        # 是否被**打分？
        def rating_by?(user)
          self.user_rating_tracks(user).exists?
        end

        # 加分
        def up_rating_by!(user, score=1)
          if rating_by? user
            :already
          else
            self.rating_by! user, score
            :up
          end
        end

        # 打低分
        def down_rating_by!(user, score=-1)
          if rating_by? user
            :already
          else
            self.rating_by! user, score
            :down
          end
        end

        # 用户进行打分
        def rating_by!(user, score=1)
          tmp_scope = self.user_rating_tracks(user)

          tmp_scope.first || tmp_scope.create(
            :score => score
          )

          _expire_rating_track_cache
        end

        # 取消打分
        def undo_rating_by!(user)
          self.user_rating_tracks(user).destroy_all

          _expire_rating_track_cache
        end

        private

        def _expire_rating_track_cache
          self.reload
          self.touch
        end

      end
    end
  end
end

