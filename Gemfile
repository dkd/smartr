source 'http://rubygems.org'
gem 'rails', ">=3.0.3"
gem "haml"
gem "settingslogic"
gem "friendly_id"
gem "sanitize"
gem "bluecloth"
gem "escape"
gem 'will_paginate', '3.0.pre'
gem "paperclip"
gem "acts-as-taggable-on", ">=2.0.6"
gem "sunspot_rails", "1.2.rc4"
gem "mysql2"
gem "devise"
gem "unicorn", :platform => :mri_19
gem "stringex"
gem "annotate"

# bundler requires these gems in development
group :development do
  gem 'rails-footnotes', :git => 'git://github.com/romanvbabenko/rails-footnotes.git', :branch => 'rails3'
end

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
end