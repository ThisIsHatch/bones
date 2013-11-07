# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bones/version"
require 'bundler'

Gem::Specification.new do |s|
  s.name        = "bones"
  s.version     = Bones::VERSION
  s.authors     = ["James McCarthy"]
  s.email       = ["james2mccarthy@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Adds some tools to speed up the development process}
  s.description = %q{Adds template actions under bones/logged_out/ and bones/logged_in for front end devs to create static templates
 and adds updates generators to create hatch standard files including kaminari views and rspec scaffold.}

  s.rubyforge_project = "bones"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.post_install_message = %q{
  ================================================================================

  Welcome to Bones
  ----------------
  You now need to create the files to get you going

    $ rails g bones:install

  If you are going to use the hatch default controllers and specs which are pretty
  useful :)

    $ rails g bones:scaffold

  ================================================================================
  }

end
