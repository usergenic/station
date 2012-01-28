module Station

  class Generator

    class ParamsRecorder

      def initialize(block)
        instance_eval(&block)
      end

      def params
        @params ||= []
      end

      def param(name, description)
        params << Station::Generator::Param.new(name, description)
      end

      # We literally don't care about anything other than the `param` method for
      # this recorder.
      def method_missing(*)
      end

    end

  end

end
