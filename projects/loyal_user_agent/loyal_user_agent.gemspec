Gem::Specification.new do |s|
  s.name    = "loyal_user_agent"
  s.version = "0.0.2"

  s.homepage    = "http://github.com/josh/useragent"
  s.summary     = "HTTP User Agent parser"
  s.description = <<-EOS
    HTTP User Agent parser
  EOS


  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.rdoc"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

  s.author = "Joshua Peek"
  s.email  = "josh@joshpeek.com"
end
