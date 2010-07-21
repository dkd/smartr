source 'http://rubygems.org'
gem 'rails', '3.0.0.beta4'

gem "mysql"

gem "authlogic", :git => "git://github.com/odorcicd/authlogic.git", :branch => "rails3"
gem "haml"
gem "settingslogic", "2.0.6"
gem "friendly_id"
gem "sanitize", "1.2.1"
gem "sunspot", :require => "sunspot"
#gem "sunspot_rails", :require => "sunspot/rails"
gem "bluecloth", "2.0.7"
gem "escape", "0.0.4"
gem "unicode", "0.3.1"
gem 'will_paginate', '3.0.pre'
gem "paperclip", "2.3.3"
gem "acts-as-taggable-on", "2.0.6"

gem 'cgi_multipart_eof_fix'
gem 'fastthread'
gem 'mongrel_experimental'

#gem "pdfkit"
group :development do
  # bundler requires these gems in development
  # gem "rails-footnotes"
end

group :test do
  # bundler requires these gems while running tests
  gem "rspec", "2.0.0.beta.4"
  gem "rspec-rails", "2.0.0.beta.4"
  gem "factory_girl", :git => "git://github.com/szimek/factory_girl.git", :branch => "rails3"
  
  gem "faker", "0.3.1"
	gem "cucumber-rails"
	gem "capybara"
	gem "database_cleaner"
end