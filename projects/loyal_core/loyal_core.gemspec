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

  s.add_dependency "rails"
  s.add_dependency "loyal_rails_kindeditor"

  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
