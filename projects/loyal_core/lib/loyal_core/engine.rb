# -*- encoding : utf-8 -*-
# rails config
require "rails_config"
require "nokogiri"
require "loyal_acts_as_paranoid"
# markdown and 语法高亮
require 'redcarpet'
require 'coderay'
# 图片上传
require 'carrierwave'
require 'mini_magick'
# 一棵树
require 'awesome_nested_set'
require "jquery-rails"
require "loyal_rails_kindeditor"

module LoyalCore
  class Engine < ::Rails::Engine
    isolate_namespace LoyalCore

    config.generators do |g|
      g.test_framework :rspec, :view_specs => true
    end

  end
end
