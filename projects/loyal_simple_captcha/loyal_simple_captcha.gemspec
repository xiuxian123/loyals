# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_captcha/version"

Gem::Specification.new do |s|
  s.name = "loyal_simple_captcha"
  s.version = SimpleCaptcha::VERSION.dup
  s.platform = Gem::Platform::RUBY 
  s.summary = "SimpleCaptcha is the simplest and a robust captcha plugin."
  s.description = "LoyalSimpleCaptcha is available to be used with Rails 3 or above and also it provides the backward compatibility with previous versions of Rails."
  s.authors = ['happy']
  s.email = "andywang7259@gmail.com"
  s.homepage = "http://github.com/xiuxian123/loyals"

  # s.add_dependency 'sprockets-helpers'

  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["{spec}/**/*"]
  s.require_paths = ["lib"]
end
