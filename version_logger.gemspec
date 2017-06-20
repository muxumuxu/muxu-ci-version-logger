$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "version_logger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "version_logger"
  s.version     = VersionLogger::VERSION
  s.authors     = ["David Miotti"]
  s.email       = ["david@muxumuxu.com"]
  s.homepage    = "https://muxumuxu.com"
  s.summary     = 'Handles project version number and changelog.'
  s.description = 'Make a version number available for the project and keep an associated changelog. Also permits version number update.'
  s.license     = "Unlicensed"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2.0.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "vandamme"
  s.add_development_dependency "shoulda-context"
end
