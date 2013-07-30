# -*- encoding : utf-8 -*-
module LoyalPassport
  class Engine < ::Rails::Engine
    isolate_namespace LoyalPassport

    config.generators do |g|
      g.test_framework :rspec, :view_specs => true
    end

  end
end
