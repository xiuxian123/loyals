# -*- encoding : utf-8 -*-
module LoyalAdmin
  class Display::Item < ActiveRecord::Base
    # attr_accessible :title, :body

    attr_accessible :target

    self.table_name = 'loyal_admin_display_items'

    self.acts_as_tiny_cached

    belongs_to :board,      :class_name => 'LoyalAdmin::Display::Board'
    belongs_to :target,     :polymorphic => true

  end
end
