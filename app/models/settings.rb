class Settings < Settingslogic
  source "#{Rails.root}/app/config/application.yml"
  namespace Rails.env
end