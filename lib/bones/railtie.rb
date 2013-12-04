require 'bones'
require 'rails'

module Bones
  class Railtie < Rails::Railtie

    initializer "canard.active_record" do |app|
      ActiveSupport.on_load :action_controller do
        include Kss::ApplicationHelper if defined?(Kss) && Rails.env.development?
      end
    end
  end
end