module Station

  class Generator

    class Param

      attr_reader :name, :options

      def initialize(name, options={})
        @name, @options = name.to_s, options
      end

    end

  end

end
