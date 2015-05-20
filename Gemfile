source 'https://rubygems.org'

gem 'puma'
gem 'rails', '4.2'

# SQL Database
gem 'mysql2'

gem 'jbuilder'
gem 'bcrypt'
gem 'email_validator'
# This guy's fork fixes an issue where websocket controllers can't be tested
# https://github.com/websocket-rails/websocket-rails/issues/218
gem 'websocket-rails', git: "https://github.com/depili/websocket-rails.git", branch: "testing_fix"
gem 'render_anywhere'

group :development, :test do
  gem 'rake'
  gem 'rack-cors'
  gem 'rspec-rails'
  gem 'rspec'
  gem "factory_girl_rails", "~> 4.0"
  gem 'guard-rspec'
  gem 'byebug'
  gem 'timecop'
  gem 'awesome_print'
end