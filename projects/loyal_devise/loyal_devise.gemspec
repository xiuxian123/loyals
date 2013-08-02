# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
# require "devise/version"

Gem::Specification.new do |s|
  s.name        = "loyal_devise"
  # s.version     = Devise::VERSION.dup
  s.version     = '2.1.8'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ["MIT"]
  s.summary     = "Flexible authentication solution for Rails with Warden"
  s.email       = "andywang7259@gmail.com"
  s.homepage    = "http://github.com/blogsoso/devise"
  s.description = "Flexible authentication solution for Rails with Warden"
  s.authors     = ['happy']

  # s.rubyforge_project = "devise"

  # s.files         = `git ls-files`.split("\n")
  # s.test_files    = `git ls-files -- test/*`.split("\n")
  # s.require_paths = ["lib"]

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "jquery-rails"
  s.add_dependency("loyal_warden")
  s.add_dependency("cancan")

  # s.add_dependency("warden", "~> 1.2.1")
  s.add_dependency("orm_adapter", "~> 0.1")
  s.add_dependency("bcrypt-ruby", "~> 3.0")
  s.add_dependency("railties", ">= 3.2.6", "< 5")
end
