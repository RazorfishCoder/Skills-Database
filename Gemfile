source 'http://rubygems.org'

gem 'rails', '~> 3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'will_paginate', '3.0.pre2'
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Application Specific Gems
# Fix a bug with encoding
gem 'couchrest_model', :git => 'https://github.com/couchrest/couchrest_model.git'
gem 'memories'
#gem 'linkedin', :git => "git@github.com:boolean/linkedin.git"
gem 'omniauth', ">= 0.1.6"
gem 'indextank'

#gem "acts_as_audited", "2.0.0.rc2"

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :test, :development do
   gem 'ruby-debug19', :require => 'ruby-debug'
   gem 'rspec-rails', "~> 2.4"
end

if File.exist?(file = File.expand_path('../CustomGemfile',__FILE__))
  instance_eval(File.read(file))
end

