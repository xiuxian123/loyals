# -*- encoding : utf-8 -*-
module LoyalSpider
  class << self
    attr_writer :config

    def config
      @config ||= Config.new
    end

    def configure
      yield self.config ||= Config.new
    end

  end

  class Config

  end
end

