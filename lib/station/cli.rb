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
      exit_with_help unless argv.first.to_s =~ /\A[a-z]/i
      generator_name = argv.shift

      target = argv.shift if argv.first.to_s =~ /\A[a-z]/i

      @station_file = StationFile.load(StationFile.find_station_file)

      generator = @station_file.generators[generator_name]

      exit_with "Unknown generator #{generator_name.inspect}" unless generator

      params = {}

      parser = OptionParser.new do |parser|
        parser.banner = "Usage: station #{generator_name} [<target>] [options]"
        parser.separator ""
        parser.separator "#{generator_name} options:"
        generator.params.each do |param|
          parser.on "--#{param.name} VALUE", param.description do |value|
            params[param.name] = value
          end
        end
      end

      parser.parse!(argv)

      required_and_missing = generator.params.select do |param|
        param.options[:required] and params[param.name].nil?
      end

      unless required_and_missing.empty?
        required_and_missing.each do |param|
          puts "Missing required option --#{param.name}"
        end
        exit 1
      end

      session = generator.new_session(target, params)
      session.generate!
    end

  end

end
