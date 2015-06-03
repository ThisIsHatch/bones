require 'bones'
require 'rails'

module Bones
  class Railtie < Rails::Railtie

    config.reload_classes_only_on_change = false

    config.watchable_dirs['/config/locales'] = ['.yml']

    config.to_prepare do
      i18n_path = I18n.load_path
      app_path_glob = File.join(Rails.root, 'config', 'locales', '**/*.yml')
      app_path = Dir[app_path_glob]
      new_path = (i18n_path | app_path).keep_if { |file| File.exists?(file) }
      I18n.load_path = new_path
      I18n.reload!
    end
  end
end