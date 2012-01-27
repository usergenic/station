require "station/generator/session"
require "station/generator/template_binding"
require "fileutils"

module Station

  class Generator

    attr_reader :name, :opts, :block

    def initialize(name=nil, opts={}, &block)
      @name, @opts, @block = name, opts, block
    end

    def generate!(target=nil, opts={})
      new_session(target).instance_eval(&block)
    end

    def new_session(target=nil)
      Session.new(target, self)
    end

  end

end
