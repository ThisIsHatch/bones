require 'rails/generators/base'

module Bones
  module Generators

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'Bones Rails Install'

      def install_steps
        route "mount Bones::Engine => '/bones' unless Rails.env.production?"
        copy_file 'example.html.erb', 'app/views/bones/wireframes/example.html.erb'
        copy_file 'create_event.html.erb', 'app/views/bones/wireframes/create_event.html.erb'
        copy_file 'event.html.erb', 'app/views/bones/wireframes/event.html.erb'
        copy_file 'components.html.erb', 'app/views/bones/components/index.html.erb'
        directory 'stylesheets', 'app/assets/stylesheets'
      end
    end
  end
end
