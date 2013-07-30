# -*- encoding : utf-8 -*-
require "loyal_core/engine"
require "loyal_core/memoist"
require "loyal_core/utils"
require "loyal_core/config"
require "loyal_core/acts"
require "loyal_core/action_helper"
require "loyal_core/action_controller"
require "loyal_core/action_view"
require "loyal_core/active_model"

module LoyalCore
  
end

I18n.load_path += Dir[Pathname.new(__FILE__).join('..', '..', 'config', 'locales', '**', '*.{rb,yml}').to_s]

