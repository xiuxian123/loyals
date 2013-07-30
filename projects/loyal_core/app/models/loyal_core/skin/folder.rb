# -*- encoding : utf-8 -*-
module LoyalCore
  class Skin::Folder < ActiveRecord::Base
    # attr_accessible :title, :body

    self.acts_as_paranoid

    self.acts_as_tiny_cached

    attr_accessible :name, :space, :permalink, :instroduction,
      :description, :short_name

    self.loyal_core_acts_as_tree

    # 去空格
    self.strip_whitespace_before_validation :name, :short_name, :space, :permalink

    # 校验
    validates :name, :short_name, :presence => true

    self.loyal_core_acts_as_has_permalink :with_space => true

    has_many :recipes, :class_name => '::LoyalCore::Skin::Recipe'

  end
end
