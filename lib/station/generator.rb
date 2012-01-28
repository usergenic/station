require "station/generator/param"
require "station/generator/params_recorder"
require "station/generator/plan"
require "station/generator/session"
require "station/generator/template_binding"
require "fileutils"

module Station

  class Generator

    attr_reader :name, :options, :params, :block

    def initialize(name=nil, options={}, &block)
      @name, @options, @block = name, options, block
    end

    def generate!(target=nil, params={})
      new_session(target).instance_eval(&block)
    end

    def new_session(target=nil, params={})
      Session.new(target, params, self)
    end

    def params
      @params ||= block ? ParamsRecorder.new(block).params : []
    end

  end

end
