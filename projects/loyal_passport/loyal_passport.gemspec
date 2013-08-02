$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "loyal_passport/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loyal_passport"
  s.version     = LoyalPassport::VERSION
  s.authors     = ["happy"]
  s.email       = ["andywang7259@gmail.com"]
  s.homepage    = "http://blogsoso.net"
  s.summary     = "Summary of LoyalPassport."
  s.description = "Description of LoyalPassport."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "jquery-rails"
  s.add_dependency "loyal_core"
  s.add_dependency "loyal_devise"
  s.add_dependency "cancan"

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end
