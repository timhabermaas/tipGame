source 'http://rubygems.org'

gem 'rails', '3.1.4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => :production

gem 'jquery-rails', '>= 1.0.12'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for certain environments:
# gem 'rspec', :group => :test
# group :test do
#   gem 'webrat'
# end

gem 'savon'

gem 'dynamic_form'

group :test, :development do
  gem 'rspec-rails', '~> 2.0'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'growl'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
  gem 'factory_girl_rails'
  gem 'capybara'
end
