module Station

  class CLI

    def self.run(argv)
      new(argv).run
    end

    def initialize(argv)
      @argv = argv
      @station_file = StationFile.find_station_file
    end

    def run
      puts "station using #{@station_file.inspect} with #{@argv.inspect}"
    end

  end

end
