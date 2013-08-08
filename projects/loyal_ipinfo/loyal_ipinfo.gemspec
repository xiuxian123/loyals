$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "loyal_ipinfo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loyal_ipinfo"
  s.version     = LoyalIpinfo::VERSION
  s.authors     = ["happy"]
  s.email       = ["andywang7259@gmail.com"]
  s.homepage    = "http://develop.xiuxian123.com/"
  s.summary     = "Summary of LoyalIpinfo."
  s.description = "Description of LoyalIpinfo."

  s.files = Dir["{resources,app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
end
