module Smartr
  
  class Settings
    def self.[](value, environment = Rails.env)
      @@settings ||= YAML::load( File.open( 'app/config/application.yml' ) ).with_indifferent_access
      @@settings[environment][value]
    rescue Exception => e
      []
    end
  end

end