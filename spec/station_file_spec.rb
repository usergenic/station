require "spec_helper"

module Station

  describe StationFile do

    describe StationFile, ".find_station_file" do

      it "should find any of the standard files in the current folder" do
        file = StationFile.find_station_file("spec/fixtures/folder_with_dot_station")
        file.should == File.expand_path("spec/fixtures/folder_with_dot_station/.station")

        file = StationFile.find_station_file("spec/fixtures/folder_with_station_file")
        file.should == File.expand_path("spec/fixtures/folder_with_station_file/Stationfile")
      end

      it "should walk up the folder structure until it finds a station file" do
        file = StationFile.find_station_file("spec/fixtures/folder_with_no_station_file")

        # it should find the one in this gem's root
        file.should == File.expand_path("Stationfile")
      end

    end

  end

end
