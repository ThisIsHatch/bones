module Bones
  module Generators

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :roles, :type => :array, :default => "admin", :desc => 'The roles to create controller specs for in the template'
    
      def copy_controller_file
        copy_file "controller.rb", "lib/templates/rails/scaffold_controller/controller.rb"
        template "controller_spec.rb.erb", "lib/templates/rspec/scaffold/controller_spec.rb"
      end

    end
  end
end