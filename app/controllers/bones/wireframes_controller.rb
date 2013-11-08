class Bones::WireframesController < ApplicationController

  before_filter :capture_persisted_object
  before_filter :initialize_persisted_object

  def initialize_persisted_object
    instance_variable_set "@#{action_name}", Bones::PersistedObject.get(action_name)
  end

  def capture_persisted_object
    new_params = params.dup.delete_if do |key, value|
      %w(utf8 commit controller action).include?(key) || !value.is_a?(Hash)
    end

    new_params.each_pair do |name, attributes|
      Bones::PersistedObject.get(name, attributes)
    end
  end

end
