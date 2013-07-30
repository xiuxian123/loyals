# -*- encoding : utf-8 -*-
module LoyalCore
  # 
  class LikeTrack < ActiveRecord::Base
    attr_accessible :position

    # self.acts_as_tiny_cached

    self.loyal_passport_acts_as_creator_able

    belongs_to :target, :polymorphic => true, :counter_cache => :liked_count

    validates_uniqueness_of :created_by, :scope => [:target_id, :target_type]
  end
end
