# -*- encoding : utf-8 -*-
require "protected_attributes"
require "tiny_cache"
# rails config
require "rails_config"
require 'dalli'
require "nokogiri"
require "loyal_acts_as_paranoid"
# markdown and 语法高亮
require 'redcarpet'
require 'coderay'
require 'loyal_simple_captcha'
# 图片上传
require 'carrierwave'
require 'mini_magick'
# 一棵树
require 'awesome_nested_set'
require "jquery-rails"
require "loyal_rails_kindeditor"

require 'sanitize'
require 'mechanize'
require 'rest-client'
require 'kaminari'       # 分页插件

# 图片上传
require 'carrierwave'
#  gem 'carrierwave-mongoid'
require'mini_magick'

module LoyalCore
  class Engine < ::Rails::Engine
    isolate_namespace LoyalCore

    config.generators do |g|
      g.test_framework :rspec, :view_specs => true
    end

  end
end
