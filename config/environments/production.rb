Smartr::Application.configure do
  config.cache_classes = true
  config.whiny_nils = false
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.action_controller.cache_store = [:file_store, "#{Rails.root}/tmp/cache"]
  config.action_mailer.perform_deliveries = true
  config.active_support.deprecation = :log
  config.action_mailer.raise_delivery_errors = false
  config.secret_token ='94b9c594695e69bdef6b1d4be037af5853be976b39a52a02f260fca0d0a36a8f913572bfdb631f55971a3b10b8dd9a875f9776ca61371741544e6ccc064dd41e'

  # Compress JavaScript and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true
end
