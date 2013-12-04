require "bones/version"

module Bones
  if defined?(Rails)
    require 'bones/engine'
    require 'bones/railtie' if Rails::VERSION::MAJOR >= 3
  end
end

