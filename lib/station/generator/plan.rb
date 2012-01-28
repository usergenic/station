module Station
  class Generator
    class Plan

      def describe(steps=self.steps.uniq)
        descriptions = steps.map do |conflict, name, *args|
          send "describe_#{name}", *args
        end
        descriptions.join("\n")
      end

      def describe_conflicts
        conflicts = steps.uniq.select { |conflict, name, *args| conflict }
        describe(conflicts)
      end

      def describe_write_file(filename, content)
        "generate file: #{filename}"
      end

      def describe_create_folder(path)
        "generate folder: #{path}"
      end

      def create_folder(path)
        FileUtils.mkdir_p(path)
      end

      def execute!
        steps.uniq.each { |step| send *step }
      end

      def steps
        @steps ||= []
      end

      def valid?
        steps.uniq.all? { |name, *args| send "validate_#{name}", *args }
      end

      def write_file(filename, content)
        File.open(filename, 'w') { |f| f.write(content) }
      end

    end

  end

end
