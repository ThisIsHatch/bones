class Bones::WireframesController < ApplicationController

  before_filter :capture_persisted_object

  def capture_persisted_object
    new_params = params.dup.delete_if do |key, value|
      %w(utf8 commit controller action).include?(key) || !value.is_a?(Hash)
    end

    new_params.each_pair do |name, attributes|
      Bones::PersistedObject.create(name, attributes)
    end
  end

end
