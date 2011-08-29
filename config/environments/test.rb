Smartr::Application.configure do

  # Settings specified here will take precedence over those in config/environment.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!

  #config.gem 'jscruggs-metric_fu', :version => '1.1.5', :lib => 'metric_fu', :source => 'http://gems.github.com'

  config.cache_classes = true
  config.i18n.default_locale = :en
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :stderr
  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  config.secret_token ='94b9c594695e69bdef6b1d4be037af5853be976b39a52a02f260fca0d0a36a8f913572bfdb631f55971a3b10b8dd9a875f9776ca61371741544e6ccc064dd41e'
  #Sunspot.config.solr.url = 'http://localhost:8981/solr'
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end
require 'net/http'
ReactReporter.configure do |c|
  c.api_key = "f6cc822def064ecab9595ba2568a3435"
  c.host = "reactualize.dkd.de"
  c.port = 80
end
