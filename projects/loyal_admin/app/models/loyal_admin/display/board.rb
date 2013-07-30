# -*- encoding : utf-8 -*-
module LoyalAdmin
  class Display::Board < ActiveRecord::Base
    self.acts_as_paranoid

    self.acts_as_tiny_cached

    attr_accessible :name, :space, :permalink, :instroduction,
      :description, :item_ids, :short_name

    self.table_name = 'loyal_admin_display_boards'
    self.loyal_core_acts_as_tree

    has_many :items, :class_name => "LoyalAdmin::Display::Item",
      :include => [:target], :dependent => :destroy

    self.strip_whitespace_before_validation :name, :short_name, :space, :permalink

    validates :name, :short_name, :presence => true

    self.loyal_core_acts_as_has_permalink :with_space => true

    # display_board.append_item category_1, :position => 2
    def append_item *args
      options = args.extract_options!
      target = args.first
      self.items.create options.slice(:position).merge(:target => target)
    end
  end
end
