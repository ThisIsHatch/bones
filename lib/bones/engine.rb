require "bones"
require "rails"

module Bones

  class Engine < Rails::Engine

    isolate_namespace Bones

  end

end