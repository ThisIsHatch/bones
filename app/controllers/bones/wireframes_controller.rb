class Bones::WireframesController < ApplicationController

  before_filter :capture_persisted_object
  before_filter :initialize_persisted_object

  def initialize_persisted_object
    object = Bones::PersistedModel.find(action_name)
    instance_variable_set "@#{action_name}", object
  end

  def capture_persisted_object
    new_params = params.dup.delete_if do |key, value|
      %w(utf8 commit controller action).include?(key) || !value.is_a?(Hash)
    end

    new_params.each_pair do |name, attributes|
      Bones::PersistedModel.create(name, attributes)
    end
  end

end
