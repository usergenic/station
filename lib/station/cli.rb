require "station"
require "optparse"

module Station

  class CLI

    attr_accessor :argv

    def self.run(argv)
      new(argv).run
    end

    def initialize(argv)
      @argv = argv
    end

    def exit_with(message)
      puts message
      exit(1)
    end

    def exit_with_help
      exit_with "Usage: station <generator> [target] [options]"
      exit(1)
    end

    def run
      generator_name = argv.shift.to_s

      exit_with_help unless generator_name =~ /\A[a-z]/i

      @station_file = StationFile.load(StationFile.find_station_file)

      generator = @station_file.generators[generator_name]

      exit_with "Unknown generator #{generator_name.inspect}" unless generator

      OptionParser.new do |parser|
        generator.params.each do |param|
          parser.on "--#{param.name} VALUE", param.description do |value|
            options[param.name] = value
          end
        end
      end

      generator.new_session(target)

      puts "station using #{@station_file.inspect} with #{@argv.inspect}"
    end

  end

end
