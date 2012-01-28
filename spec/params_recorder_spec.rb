require "spec_helper"

describe Station::Generator::ParamsRecorder do

  it "should record any call to the params method inside its block" do

    block = lambda do
      this(doesnt matter)
      param :but,  "this does"
      param "and", "so does this"
      also this, doesnt(too)
    end

    recorder = Station::Generator::ParamsRecorder.new(block)

    recorder.params[0].name.should == "but"
    recorder.params[0].options[:description].should == "this does"

    recorder.params[1].name.should == "and"
    recorder.params[1].options[:description].should == "so does this"

  end

end
