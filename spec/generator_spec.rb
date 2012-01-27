require 'spec_helper'

module Station

  describe Generator do

    describe Generator::Session do

      describe Generator::Session, "#default_target" do

        it "has a default target and it is set with set_default_target" do
          gen = Generator.new
          ssn = gen.new_session
          ssn.default_target.should == "."
          ssn.set_default_target("xyz")
          ssn.default_target.should == "xyz"
        end

      end

      describe Generator::Session, "#target" do

        it "falls back on default target when target is not present" do
          gen = Generator.new
          ssn = gen.new_session
          ssn.set_default_target("apples")
          ssn.target.should == "apples"
        end

        it "does not fall back on default target if target is present" do
          gen = Generator.new
          ssn = gen.new_session("oranges")
          ssn.set_default_target("apples")
          ssn.target.should == "oranges"
        end

      end

      describe Generator::Session, "#erb" do

        it "should render an ERB template" do
          gen = Generator.new
          ssn = gen.new_session
          ssn.erb("<%= 1 + 1 %>").should == "2"
        end

        it "should treat values in options hash as named values in ERB template" do
          gen = Generator.new
          ssn = gen.new_session
          ssn.erb("<%= monkey %>", :monkey => "gorilla").should == "gorilla"
        end

        it "should use values in initialization options as named values in ERB template" do
          gen = Generator.new(nil, :monkey => "spidermonkey")
          ssn = gen.new_session
          ssn.erb("<%= monkey %>").should == "spidermonkey"
        end

        it "should use override values in initialization options with method options hash" do
          gen = Generator.new(nil, :monkey => "spidermonkey")
          ssn = gen.new_session
          ssn.erb("<%= monkey %>", :monkey => "baboon").should == "baboon"
        end

        it "should treat missing values as nil in templates" do
          gen = Generator.new
          ssn = gen.new_session
          ssn.erb("(<%= wtf %>)").should == "()"
        end

      end

      describe Generator::Session, "#file" do

        it "should create a file in the file system" do
          File.expects(:open).with("some/file/path.rb","w")
          gen = Generator.new
          ssn = gen.new_session
          ssn.file "some/file/path.rb", <<-eof
            my file
          eof
        end

      end

    end

    describe Generator, "#initialize" do

      it "should assign a name from first argument" do
        Generator.new("something").name.should == "something"
      end

    end

    describe Generator, "#generate!" do

      it "should evaluate the block on the Generator instance" do
        Generator::Session.any_instance.expects(:hello!)
        gen = Generator.new { hello! }
        gen.generate!
      end

    end

    describe Generator, "#unindent" do

      it "should shift a multiline string all the way to the left" do
        gen = Generator.new
        ssn = gen.new_session
        ssn.unindent(<<-eof).should == "1\n  2\n    3\n"
            1
              2
                3
        eof
      end

    end

  end

end
