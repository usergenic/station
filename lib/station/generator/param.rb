module Station

  class Generator

    class Param

      attr_reader :name, :description

      def initialize(name, description)
        @name, @description = name.to_s, description
      end

    end

  end

end
