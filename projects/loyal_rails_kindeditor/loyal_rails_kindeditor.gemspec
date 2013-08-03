# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "loyal_rails_kindeditor"
  # s.version     = RailsKindeditor::VERSION
  s.version     = '0.0.9'

  s.platform    = Gem::Platform::RUBY
  s.authors     = "happy"
  s.email       = "andywang7259@gmail.com"
  s.homepage    = "http://github.com/blogsoso"
  s.summary     = "Kindeditor for Ruby on Rails"
  s.description = "rails_kindeditor will helps your rails app integrate with kindeditor, including images and files uploading."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["Rakefile", "README.md"]

  s.add_dependency("carrierwave")
  s.add_dependency("mini_magick")
end

