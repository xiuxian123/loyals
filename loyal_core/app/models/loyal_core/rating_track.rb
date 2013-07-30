# -*- encoding : utf-8 -*-
module LoyalCore
  class RatingTrack < ActiveRecord::Base
    attr_accessible :score

    # self.acts_as_tiny_cached

    self.loyal_passport_acts_as_creator_able

    # TODO: counter_cache 是否需要？
    belongs_to :target, :polymorphic => true, :counter_cache => true

    # 保存之后需要 更新好评度，与差评度
    after_create do |r|
      if r.score > 0
        r.target_type.constantize.update_counters(r.target_id, :up_rating   => r.score)
      else
        r.target_type.constantize.update_counters(r.target_id, :down_rating => r.score)
      end
    end

    after_destroy do |r|
      if r.score > 0
        r.target_type.constantize.update_counters(r.target_id, :up_rating   => -(r.score))
      else
        r.target_type.constantize.update_counters(r.target_id, :down_rating => -(r.score))
      end
    end

    validates_uniqueness_of :created_by, :scope => [:target_id, :target_type]
  end
end
