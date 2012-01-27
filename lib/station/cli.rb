module Station

  class CLI

    def self.run(argv)
      new(argv)
    end

    def initialize(argv)
      @argv = argv
    end

    def run
      puts "station is running with #{@argv.inspect}"
    end

  end

end
