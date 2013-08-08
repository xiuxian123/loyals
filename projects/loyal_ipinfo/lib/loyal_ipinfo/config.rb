# -*- encoding : utf-8 -*-
module LoyalIpinfo
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
    def default_adapter
      @default_adapter ||= :qqwry  # 纯真qq
    end

    def default_adapter= _adapter
      @default_adapter ||= _adapter
    end

    def default_library_file_path
      @default_library_file_path ||= "#{File.dirname(__FILE__)}/../../resources/qqwry.dat"
    end

    def default_library_file_path= path
      @default_library_file_path ||= path
    end
  end
end

