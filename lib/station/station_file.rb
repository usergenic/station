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

    def initialize(filename, content)
      instance_eval(content, filename)
    end

    def generator(name, options={}, &block)
      generators[name] = Generator.new(name, options, &block)
    end

    def generators
      @generators ||= {}
    end
  end

end
