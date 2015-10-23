$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/links/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecm_links2"
  s.version     = Ecm::Links::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/ecm_links"
  s.summary     = "Link management for active admin."
  s.description = "Link management for active admin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0", '< 5.0'
  s.add_dependency "active_admin-acts_as_list"
  s.add_dependency "active_admin-awesome_nested_set", '~> 0.0.8'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'awesome_nested_set'
  s.add_dependency "awesome_nested_set-tools", '~> 0.0.2'
  s.add_dependency 'friendly_id'
  s.add_dependency 'RedCloth'

  s.add_development_dependency "sqlite3"

  # Development Server
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency "thin"
  s.add_development_dependency 'rails-i18n'
  s.add_development_dependency 'devise'
  s.add_development_dependency "twitter-bootstrap-rails"

  # Active admin
  s.add_development_dependency 'activeadmin', '~> 1.0.0.pre2'
  s.add_development_dependency "therubyracer"
  s.add_development_dependency "less-rails"
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'coffee-rails'

  # Documentation
  s.add_development_dependency "yard"

  # Tests
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers', '~> 2.8.0'
  s.add_development_dependency 'factory_girl_rails'

  # Test automation
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'
end
