$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "loyal_spider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loyal_spider"
  s.version     = LoyalSpider::VERSION
  s.authors     = ["happy"]
  s.email       = ["andywang7259@gmail.com"]
  s.homepage    = "http://github.com/xiuxian123"
  s.summary     = "Summary of LoyalSpider."
  s.description = "Description of LoyalSpider."

  s.files = Dir["{spec app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # s.add_dependency "rails", "~> 4.0.0"

  # s.add_development_dependency "sqlite3"
end
