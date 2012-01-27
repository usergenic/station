module Station

  class StationFile

    FILENAMES = ["Stationfile", ".station"]

    def self.find_station_file(dir = Dir.pwd)
      dir = File.expand_path(dir)

      while dir != "/"
        FILENAMES.each do |filename|
          search_path = File.join(dir, filename)
          return search_path if File.exist?(search_path)
        end

        return nil if dir == "/"

        dir = File.dirname(dir)
      end
    end

    def self.load(filename)
      new(filename, File.read(filename))
    end

    attr_accessor :generators

    def initialize(filename, content)
      @generators = {}
      instance_eval(content, filename)
    end

    def generator(name, opts={}, &block)
      opts[:generators] = generators
      generators[name] = Generator.new(name, opts, &block)
    end

  end

end
