$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "loyal_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loyal_admin"
  s.version     = LoyalAdmin::VERSION
  s.authors     = ["happy"]
  s.email       = ["andywang7259@gmail.com"]
  s.homepage    = "http://develop.xiuxian123.com"
  s.summary     = "Summary of LoyalAdmin."
  s.description = "Description of LoyalAdmin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
