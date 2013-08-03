Gem::Specification.new do |s|
  s.name                  = "loyal_acts_as_paranoid"
  s.version               = "0.0.4"
  s.platform              = Gem::Platform::RUBY
  s.authors               = ["Goncalo Silva", "Charles G.", "Rick Olson"]
  s.email                 = ["andywang7259@gmail.com"]
  s.homepage              = "https://github.com/blogsoso/acts_as_paranoid"
  s.summary               = "Active Record (~>3.2) plugin which allows you to hide and restore records without actually deleting them."
  s.description           = "Active Record (~>3.2) plugin which allows you to hide and restore records without actually deleting them. Check its GitHub page for more in-depth information."
  s.rubyforge_project     = s.name


  s.add_dependency "rails"

  # s.required_rubygems_version = ">= 1.3.6"

  # s.add_dependency "activerecord", "~> 4.0.0"

  s.files        = Dir["{lib}/**/*.rb", "LICENSE", "*.markdown"]
end
