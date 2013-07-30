# -*- encoding : utf-8 -*-
module LoyalCore
  class Engine < ::Rails::Engine
    isolate_namespace LoyalCore

    config.generators do |g|
      g.test_framework :rspec, :view_specs => true
    end

  end
end
