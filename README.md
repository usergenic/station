Station
=======

It generates files and folder structures from templates that you define.

Installation
------------

You can install via rubygems:

    $ gem install station
    Fetching: station-0.0.0.gem (100%)
    Successfully installed station-0.0.0
    1 gem installed

Usage
-----

Station works kind of like `rake` in that it looks for a `Stationfile` or
`.station` file in the current directory and if it doesn't find one, it walks up
until it finds one or gets to the root of the volume and complains.

    $ station
    Usage: station <generator> [target] [options]


Overview
--------

Station uses a simple DSL for expressing file and folder structure generators
that looks like the following.  Here is an example of how you might define a
generator for a typical rubygem project complete with rspec support.

    # My Stationfile
    require "active_support/inflector" # for String#underscore/camelize

    generator "new_gem" do

      param :name,     "The human-friendly name of your gem (use spaces and capitalize)"
      param :version,  "A version number in Rubygems format (defaults to 0.0.0)"
      param :email,    "Your email address"
      param :author,   "Your name"
      param :homepage, "A project homepage"
      param :author,   "Your name"
      param :email,    "Your email address"

      file "<%= name.underscore %>.gemspec", <<-eof
        Gem::Specification.new do |s|
          s.name          = "<%= name %>"
          s.version       = "<%= version %>"
          s.authors       = ["<%= author %>"]
          s.email         = ["<%= email %>"]
          s.homepage      = <%= homepage %>
          s.summary       = %w{TODO: Write a summary for your Gem}
          s.description   = %w{TODO: Write a description for your Gem}
          s.files         = `git ls-files`.split("\n")
          s.executables   = s.files.grep(/^bin\//).map{ |f| File.basename(f) }
          s.require_paths = ['lib']
          s.add_development_dependency "rspec"
        end
      eof

      file "Gemfile", <<-eof
        source "http://rubygems.org"
        gemspec
      end

      file "lib/<%= name.underscore %>.rb", <<-eof
        require "<%= name.underscore %>/version"
        module <%= name.camelize %>
        end
      eof

      file "spec/spec_helper.rb", <<-eof
        require "<%= name.underscore %>"
        require "rspec/autorun"

        RSpec.configure do |config|
          config.mock_with :mocha
        end
      eof

      file "spec/<%= name.underscore %>_spec.rb", <<-eof
        require "spec_helper"

        describe <%= name.camelize %> do
          it "should exist" do
            <%= name.camelize %>.should_not be_nil
          end
        end
      oef

    end

Notice that ERB is used in file path strings as well as in template source.
This is done specifically to reduce mode switching and to make it easy/clearer
for templates to refer to the local variable values being passed in when you run
Station.
