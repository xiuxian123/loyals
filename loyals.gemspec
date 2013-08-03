$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "loyals/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loyals"
  s.version     = Loyals::VERSION
  s.authors     = ["happy"]
  s.email       = ["andywang7259@gmail.com"]
  s.homepage    = "http://develop.xiuxian123.com"
  s.summary     = "Summary of Loyals."
  s.description = "Description of Loyals."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
 
  s.add_dependency "tiny_cache"
  s.add_dependency "loyal_core"
  s.add_dependency "loyal_admin"
  s.add_dependency "loyal_passport"

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
