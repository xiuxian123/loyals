# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise/version"

Gem::Specification.new do |s|
  s.name        = "loyal_devise"
  s.version     = Devise::VERSION.dup
  # s.version     = '2.1.10'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ["MIT"]
  s.summary     = "Flexible authentication solution for Rails with Warden"
  s.email       = "contact@plataformatec.com.br"
  s.homepage    = "http://github.com/plataformatec/devise"
  s.description = "Flexible authentication solution for Rails with Warden"
  s.authors     = ['José Valim', 'Carlos Antônio']

  s.rubyforge_project = "loyal_devise"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  # s.files         = `git ls-files`.split("\n")
  # s.test_files    = `git ls-files -- test/*`.split("\n")
  # s.require_paths = ["lib"]

  s.add_dependency("loyal_warden")
  s.add_dependency("omniauth")

  s.add_dependency("orm_adapter", "~> 0.1")
  s.add_dependency("bcrypt-ruby", "~> 3.0")
  s.add_dependency("railties", ">= 3.2.6", "< 5")
end
