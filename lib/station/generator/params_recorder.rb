module Station

  class Generator

    class ParamsRecorder

      def params
        @params = []
      end

      def param(name, description)
        params << Param.new(name, description)
      end

      # We literally don't care about anything other than the `param` method for
      # this recorder.
      def method_missing(*)
      end

    end

  end

end
