# -*- encoding : utf-8 -*-
module LoyalCore
  module ActiveModel
    autoload :StripWhitespace,  "#{File.dirname(__FILE__)}/active_model/strip_whitespace"
    autoload :FixCounterCache,  "#{File.dirname(__FILE__)}/active_model/fix_counter_cache"
    autoload :HumanDisplayAble, "#{File.dirname(__FILE__)}/active_model/human_display_able"
  end
end

if defined?(::ActiveRecord::Base)
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActiveModel::StripWhitespace
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActiveModel::FixCounterCache
  ::ActiveRecord::Base.send :include, ::LoyalCore::ActiveModel::HumanDisplayAble
end


