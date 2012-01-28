module Station

  class Generator

    class ParamsRecorder

      def initialize(block)
        instance_eval(&block)
      end

      def params
        @params ||= []
      end

      def param(name, *args)
        options = args.last.is_a?(Hash) ? args.pop.dup : {}
        options[:description] ||= args.last if args.last
        params << Station::Generator::Param.new(name, options)
      end

      # We literally don't care about anything other than the `param` method for
      # this recorder.
      def method_missing(*)
      end

    end

  end

end
