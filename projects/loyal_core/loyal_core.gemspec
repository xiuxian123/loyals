$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "loyal_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loyal_core"
  s.version     = LoyalCore::VERSION
  s.authors     = ["happy"]
  s.email       = ["andywang7259@gmail.com"]
  s.homepage    = "http://develop.xiuxian123.com"
  s.summary     = "Summary of LoyalCore."
  s.description = "Description of LoyalCore."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "protected_attributes"

  # a memcached client
  s.add_dependency  'dalli'

  # rails config
  s.add_dependency "rails_config"

  s.add_dependency "nokogiri"

  # markdown and 语法高亮
  s.add_dependency 'redcarpet'
  # gem 'albino'
  s.add_dependency 'coderay'

  # 图片上传
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'

  # 一棵树
  s.add_dependency 'awesome_nested_set'

  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "tiny_cache"

  s.add_dependency 'sanitize'
  s.add_dependency 'mechanize'
  s.add_dependency 'rest-client'
  s.add_dependency 'kaminari'       # 分页插件

  # s.add_dependency 'classifier'     # 归类

  # 图片上传
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'

  s.add_dependency "loyal_rails_kindeditor"
  s.add_dependency "loyal_acts_as_paranoid"
  s.add_dependency "loyal_simple_captcha"

  # 标签
  s.add_dependency 'acts-as-taggable-on'

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"

end
