require "erb"

module Station

  class Generator

    class Session

      attr_reader :generator, :params

      def initialize(target, params, generator)
        params = Hash[ params.map { |k,v| [k.to_s, v] } ]

        @target, @params, @generator = target, params, generator

        required_and_missing = generator.params.select do |param|
          param.options[:required] and params[param.name].nil?
        end

        unless required_and_missing.empty?
          raise ArgumentError, "Missing required param(s) for #{generator.name} generator: #{required_and_missing.map { |p| p.name }.join(',')}"
        end
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

      def file(filename, content="", params={})
        file!(filename, unindent(content), params)
      end

      def file!(filename, content="", params={})
        filename = erb(filename, params)
        content  = erb(content, params)
        write_file(filename, content)
      end

      def plan
        return @plan if @plan
        @plan = Plan.new
        instance_eval(&generator.block) if generator.block
        @plan
      end

      def ensure_folder(path)
        plan.steps << [:create_folder, path] unless File.directory?(path)
      end

      def write_file(filename, content)
        ensure_folder(File.dirname(filename))
        plan.steps << [:write_file, filename, content]
      end

      def param(name, *args)
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
