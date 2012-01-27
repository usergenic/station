module Station

  class Generator

    class Session

      attr_reader :generator, :params

      def initialize(target, params, generator)
        @target, @params, @generator = target, params, generator
      end

      def set_default_target(default_target)
        @default_target = default_target
      end

      def default_target
        @default_target ||= "."
      end

      def erb(string, params={})
        template_binding = TemplateBinding.new(self.params.merge(params))
        ERB.new(string).result(template_binding.binding)
      end

      def file(filename, content=nil, params={})
        filename = erb(filename, params)
        content  = unindent(erb(content, params))
        write_file(filename, content)
      end

      def write_file(filename, content)
        File.open(filename, "w") { |file| file.write(content) }
      end

      def param(name, description)
        :noop # this is handled by the generator's parser
      end

      def target
        @target || default_target
      end

      def unindent(string)
        leftmost_nonspace = string.scan(/^( *)[^ ]/).map { |m| m[0].size }.min
        string.gsub(/ {#{leftmost_nonspace.to_i}}/,'')
      end

    end

  end

end
