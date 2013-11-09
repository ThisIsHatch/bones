module Bones

  # == Bones::PersistedModel
  #
  # <tt>Bones::PersistedModel</tt> lets you build wireframes with simpe
  # mock objects that are persisted across controller actions. The view
  # /app/views/bones/wireframes/create_event
  #
  # <h1>Create Event</h1>
  # <%= form_for Bones::PersistedModel.new('Event'), url: 'event', method: 'get' do |f| %>
  #   <%= f.text_field :description %>
  #   <%= f.text_field :starts_at %>
  #   <%= f.text_field :ends_at %>
  #   <%= f.submit %>
  # <% end %>
  #
  # will build an new Event persisted model. When the form is submitted it will
  # render the /app/views/bones/wireframes/event wireframe.
  # The <tt>Bones::WireframesControler</tt> captures any properly formatted form fileds submitted
  # via a GET action and creates persisted models from those submitted attributes. So the
  # above 'create_event' form will send the parameters to the 'event' view (wireframe).

  # When rendering the 'event' view <tt>Bones::WireframesControler</tt> will
  # attempt to find a persisted model Event instance and populate @event with it.
  # therefor when rendered /app/views/bones/wireframes/event will display the entered
  # Event values submitted in the create_event view
  #
  # <h1><%= @event.description</h1>
  # <p>Starts at <%= @event.starts_at %> and ends at <%= @event.ends_at %></p>
  #
  # once the Event form has been submitted the object can be accesses accross all
  # subsequent wireframes so quite sofisticated flows can be buit.
  #
  # Additionally <tt>Bones::PersistedModel</tt> will first attempt to use existing
  # models so working versions of existing models can be seamlessly integrated into
  # the wireframes.
  class PersistedModel

    # +new+ is like ActiveRecord's +new+ but when called attempts to find
    # an existing model with `name`, if no model (or persisted model) is
    # found a persisted model is created. Once found the `attributes` are
    # assigned to a new instance of the found class. For example
    #
    # class Vehicle < ActiveRecord::Base
    # end
    #
    # Bones::PersistedModel.new('vehicle', wheels: 4, color: 'red')
    #
    # builds a new instance of Vehicle, whereas
    #
    # Bones::PersistedModel.new('car', wheels: 3, color: 'blue')
    #
    # creates a new persisted model Car and builds a new instance of it.
    def self.new(name, attributes={})
      klass_for(name).new(attributes)
    end

    # +create+ is like ActiveRecord's +create+ but when called attempts to find
    # an existing model with `name`, if no model (or persisted model) is
    # found a persisted model is created. Once found a new instance of the found
    # class is created with the given `attributes`. For example
    #
    # class Vehicle < ActiveRecord::Base
    # end
    #
    # Bones::PersistedModel.create('vehicle', wheels: 4, color: 'red')
    #
    # creates a new instance of Vehicle, whereas
    #
    # Bones::PersistedModel.create('car', wheels: 3, color: 'blue')
    #
    # creates a new persisted model Car and creates an instance of it.
    def self.create(name, params={})
      klass_for(name).new(params).save(validate: false)
    end

    # Returns the first instance of the model or persisted model `name`
    #
    # class Vehicle < ActiveRecord::Base
    # end
    #
    # Bones::PersistedModel.find('vehicle')
    #
    # returns the last instance of the Vehicle model, whereas
    #
    # Bones::PersistedModel.find('car')
    #
    # returns the last instance of persisted model Car.
    def self.find(name)
      klass_for(name).last
    end

    # Returns the first instance of the model or persisted model `name`
    #
    # class Vehicle < ActiveRecord::Base
    # end
    #
    # Bones::PersistedModel.find_or_create('vehicle', wheels: 4, color: 'red')
    #
    # Creates an instance of the Vehicle model and
    #
    # Bones::PersistedModel.find_or_create('vehicle', wheels: 4, color: 'red')
    # vehicle = Bones::PersistedModel.find_or_create('vehicle', wheels: 3, color: 'blue')
    # vehicle.color # => 'red'
    # vehicle.wheels # => '4
    def self.find_or_create(name, params={})
      find(name) || create(name, params)
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

      def save(args={})
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


