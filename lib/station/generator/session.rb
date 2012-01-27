module Station

  class Generator

    class Session

      attr_reader :generator

      def initialize(target, generator)
        @target, @generator = target, generator
      end

      def set_default_target(default_target)
        @default_target = default_target
      end

      def default_target
        @default_target ||= "."
      end

      def erb(string, opts={})
        template_binding = TemplateBinding.new(generator.opts.merge(opts))
        ERB.new(string).result(template_binding.binding)
      end

      def file(filename, content=nil, opts={})
        filename = erb(filename, opts)
        content  = unindent(erb(content,  opts))
        File.open(filename, "w") { |file| file.write(content) }
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
