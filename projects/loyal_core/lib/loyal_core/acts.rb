# -*- encoding : utf-8 -*-
module LoyalCore
  autoload :ActsAsBitAble,              "#{File.dirname(__FILE__)}/acts/bit_able"
  autoload :ActsAsTree,                 "#{File.dirname(__FILE__)}/acts/tree"
  autoload :ActsAsHasAvatar,            "#{File.dirname(__FILE__)}/acts/has_avatar"
  autoload :ActsAsHasPermalink,         "#{File.dirname(__FILE__)}/acts/has_permalink"
  autoload :ActsAsContentModeAble,      "#{File.dirname(__FILE__)}/acts/content_mode_able"
  autoload :ActsAsContentDepartAble,    "#{File.dirname(__FILE__)}/acts/content_depart_able"

  autoload :ActsAsUUIDFul,              "#{File.dirname(__FILE__)}/acts/uuid_ful"
  autoload :ActsAsRatingTrackAble,      "#{File.dirname(__FILE__)}/acts/rating_track_able"
  autoload :ActsAsLikeTrackAble,        "#{File.dirname(__FILE__)}/acts/like_track_able"

  autoload :ActsAsViewsCountAble,       "#{File.dirname(__FILE__)}/acts/views_count_able"
  autoload :ActsAsNamedFilterAble,      "#{File.dirname(__FILE__)}/acts/named_filter_able"

  autoload :ActsAsSkinDishAble,         "#{File.dirname(__FILE__)}/acts/skin_dish_able"

  autoload :ActsAsCreatorAble,          "#{File.dirname(__FILE__)}/acts/creator_able"

  autoload :ActsAsPublishStatusAble,    "#{File.dirname(__FILE__)}/acts/publish_status_able"
end

if defined?(ActiveRecord::Base)
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsBitAble
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsTree
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsHasAvatar
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsHasPermalink
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsContentModeAble
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsContentDepartAble

  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsRatingTrackAble
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsLikeTrackAble

  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsViewsCountAble

  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsNamedFilterAble
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsSkinDishAble

  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsCreatorAble
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActsAsPublishStatusAble
end
