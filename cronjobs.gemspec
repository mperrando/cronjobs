$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cronjobs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cronjobs"
  s.version     = Cronjobs::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Cronjobs."
  s.description = "TODO: Description of Cronjobs."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mocha"
  s.add_development_dependency "factory_girl_rails"
end
