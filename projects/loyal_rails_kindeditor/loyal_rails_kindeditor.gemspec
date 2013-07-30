# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "loyal_rails_kindeditor"
  # s.version     = RailsKindeditor::VERSION
  s.version     = '0.0.6'

  s.platform    = Gem::Platform::RUBY
  s.authors     = "happy"
  s.email       = "andywang7259@gmail.com"
  s.homepage    = "http://github.com/blogsoso"
  s.summary     = "Kindeditor for Ruby on Rails"
  s.description = "rails_kindeditor will helps your rails app integrate with kindeditor, including images and files uploading."

  s.rubyforge_project = "loyal_rails_kindeditor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("carrierwave")
  s.add_dependency("mini_magick")
end
