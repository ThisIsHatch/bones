module Bones
  class PersistedObject

    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    # TODO find a way to get or set the persisted object if there are no params don't set them.
    def self.get(name, params={})
      klass_name = name.camelize
      klass = begin
        klass_name.constantize
      rescue
        klass = Object.const_set(klass_name, Class.new(self))
        klass.send :instance_variable_set, "@_model_name", ActiveModel::Name.new(klass, false, klass_name)
        klass
      end.new(params)
    end

    def self.object=(object)
      @object = object
    end

    def self.object
      @object ||= new
    end

    def self.new(*args)
      @object = super
    end

    def self.first; object; end
    def self.last; object; end
    def self.find; object; end

    # TODO check out how the attirbutes are created in ActiveModel. I'm sure there is a method
    # for it that does more than attr_accessor.
    def attributes; @attributes ||= {}; end

    def initialize(params={})
      params.each_pair do |attribute, value|
        @attributes[attribute] = define_attribute_accessor attribute, value
      end
    end

    def define_attribute_accessor(attribute, value)
      singleton_class.send :attr_accessor, attribute
      instance_variable_set("@#{attribute}", value)
    end

    def persisted?
      self.class.first == self
    end

  end

end unless Rails.env.production?


