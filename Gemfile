source 'http://rubygems.org'
gem 'rails', "3.0.9"
gem "sass"
gem "friendly_id"
gem "sanitize"
gem "bluecloth"
gem "escape"
gem 'will_paginate', '3.0.pre2'
gem "paperclip"
gem "acts-as-taggable-on", ">=2.0.6"
gem "sunspot_rails", "~>1.2"
gem "mysql2", "0.2.7"
gem "devise", "1.3.4"
gem "stringex"
gem "annotate"
gem "jammit"
gem "bcrypt-ruby", :require => "bcrypt"
gem "jquery-rails"
gem "rake", "0.8.7"
gem 'react_reporter', :git => "git://github.com/reactualize/react_reporter.git"
platforms :jruby do
  gem 'activerecord-jdbcmysql-adapter'
end

platforms :mri_18 do
  gem 'mongrel'
end

platforms :mri_19 do
  gem 'unicorn'
end

# bundler requires these gems while running tests
group :test do
  gem "metric_fu"
  gem 'rspec-rails', '>= 2.4.0'
  gem 'factory_girl_rails', '>=1.1.beta1'
  gem 'autotest'
  gem 'faker'
  gem 'sqlite3-ruby', '1.3.1', :require => 'sqlite3'
  gem 'shoulda'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
end

gem 'pry', :group => :development