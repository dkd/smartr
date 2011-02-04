Smartr::Application.configure do
  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false


  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.perform_deliveries = true
  
  config.active_support.deprecation = :log
  
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.secret_token ='94b9c594695e69bdef6b1d4be037af5853be976b39a52a02f260fca0d0a36a8f913572bfdb631f55971a3b10b8dd9a875f9776ca61371741544e6ccc064dd41e'
  Sunspot.config.solr.url = 'http://localhost:8982/solr'
end
