# -*- encoding : utf-8 -*-
module LoyalCore
  class Skin::Dish < ActiveRecord::Base
    attr_accessible :recipe_id, :target_id, :target_type

    belongs_to :recipe, :class_name => '::LoyalCore::Skin::Recipe'
    belongs_to :target, :polymorphic => true

  end
end
