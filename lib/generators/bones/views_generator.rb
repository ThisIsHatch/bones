require 'rails/generators'

module Bones
  module Kaminari
    module Generators
    
      SHOW_API = 'https://github.com/api/v2/json/blob/show/thisishatch/kaminari_themes'
      ALL_API  = 'https://github.com/api/v2/json/blob/all/thisishatch/kaminari_themes/master'   
     
      class ViewsGenerator < Rails::Generators::NamedBase 
      
        desc 'The Bones Kaminari Theme Generator'

        class_option :template_engine, :type => :string, :aliases => '-e', :desc => 'Template engine for the views. Available options are "erb" and "haml".'

        def self.banner #:nodoc:
          <<-BANNER.chomp
  rails g bones:views THEME [options]

      Copies all paginator partial templates to your application.
      You can choose a template THEME by specifying one from the list below:

  #{themes.map {|t| "        - #{t.name}\n#{t.description}"}.join("\n")}
  BANNER
        end

        def copy_or_fetch #:nodoc:
      
          themes = self.class.themes
          if theme = themes.detect {|t| t.name == file_name}
            download_templates theme
          else
            say %Q[no such theme: #{file_name}\n  avaliable themes: #{themes.map(&:name).join ", "}]
          end
        end
      
        private
        def self.themes
          begin
            @themes ||= open ALL_API do |json|
              files = ActiveSupport::JSON.decode(json)['blobs']
              hash = files.group_by {|fn, _| fn[0...(fn.index('/') || 0)]}.delete_if {|fn, _| fn.blank?}
              hash.map do |name, files|
                Kaminari::Generators::Theme.new name, files
              end
            end
          rescue SocketError
            []
          end
        end
      
        def download_templates(theme)
          theme.templates_for(template_engine).each do |template|
            say "      downloading #{template.name} from hatch kaminari_themes..."
            get "#{SHOW_API}/#{template.sha}", template.name
          end
        end
      
        def template_engine
          options[:template_engine].try(:to_s).try(:downcase) || 'erb'
        end
      end
    end
  end
end if Rails::Generators.find_by_namespace('kaminari:views')

