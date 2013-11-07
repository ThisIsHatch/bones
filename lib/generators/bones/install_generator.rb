require 'rails/generators/base'

module Bones
  module Generators

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      desc 'Bones Rails Install'

      def install_steps
        route "mount Bones::Engine => '/bones' unless Rails.env.production?"
      end
    end
  end
end
