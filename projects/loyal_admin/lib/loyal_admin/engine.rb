# -*- encoding : utf-8 -*-
require 'loyal_core'

module LoyalAdmin
  class Engine < ::Rails::Engine
    isolate_namespace LoyalAdmin

    config.generators do |g|
      g.test_framework :rspec, :view_specs => true
    end

  end
end
