module Bones
  class PersistedObject

    def self.new(name, params={})
      klass_for(name).new(params)
    end

    def self.find_or_create(name, params={})
      find(name) || create(name, params)
    end

    def self.find(name)
      klass_for(name).first
    end

    def self.create(name, params={})
      klass_for(name).create(params)
    end

    def self.klass_for(name)
      begin
        klass_name = name.camelize
        klass_name.constantize
      rescue
        klass = Object.const_set(klass_name, Class.new(Base))
        klass.send :instance_variable_set, "@_model_name", ActiveModel::Name.new(klass, false, klass_name)
        klass
      end
    end

    class Base

      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      def self.first; @object; end
      def self.last; @object; end
      def self.find; @object; end

      def self.create(attributes)
        new(attributes).save
      end

      def save
        self.class.send :instance_variable_set, '@object', self
      end

      def attributes; @attributes ||= {}; end

      def initialize(params={})
        params.each_pair do |attribute, value|
          create_and_set_attribute attribute, value
        end
      end

      def create_and_set_attribute(attribute, value=nil)
        define_attribute_accessor attribute
        attributes[attribute] = value
      end

      def define_attribute_accessor(attribute)
        attribute_setter = "#{attribute}="

        singleton_class.send :define_method, attribute do
          attributes[attribute]
        end

        singleton_class.send :define_method, attribute_setter do |value|
          attributes[attribute] = value
        end
      end

      def method_missing(name, *args)
        if name =~ /(\w*)=$/
          create_and_set_attribute $1, *args
        else
          create_and_set_attribute(name)
        end
      end

      def persisted?
        self.class.first == self
      end

    end

  end

end unless Rails.env.production?


