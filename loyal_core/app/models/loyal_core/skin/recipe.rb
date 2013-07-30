# -*- encoding : utf-8 -*-
module LoyalCore
  class Skin::Recipe < ActiveRecord::Base
    attr_accessible :stylesheet_text, :assets_path, :folder_id,
      :name, :short_name, :instroduction, :description,
      :stored_tags, :avatar

    scope :with_folder, ->(options={}) {
      folder = ::LoyalCore::Skin::Folder.tiny_cache_find_by :space => options[:space], :permalink => options[:permalink]

      if folder
        where(:folder_id => folder.id)
      else
        where(:id => nil)
      end
    }

    belongs_to :folder, :class_name => "::LoyalCore::Skin::Folder"

    validates_presence_of :name

    # 用于作者
    self.loyal_passport_acts_as_creator_able

    self.loyal_core_acts_as_has_avatar

    # 去空格
    self.strip_whitespace_before_validation :assets_path

  end
end
