module Smartr
  class Settings < Hash
    def self.[](value, environment = Rails.env)
      @@settings ||= YAML::load( File.open( 'config/smartr.yml' ) ).with_indifferent_access
      @@settings[environment][value]
    rescue Exception => e
      []
    end
  end
end
