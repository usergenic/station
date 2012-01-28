require "spec_helper"

describe Station::Generator::Session do

  let :readme do
    Station::Generator.new "readme" do

      param :subject, "What is your README about?", :required => true

      file "README.md", <<-eof
        <%= subject %>
        <%= "=" * subject.length %>

        Insert amazing document about <%= subject %> here.
      eof
    end
  end

  it "should create a plan" do
    plan = readme.new_session("spec/fixtures/folder_with_readme", :subject => "Thing").plan
    plan.should be_kind_of Station::Generator::Plan
  end

  describe Station::Generator::Plan do

    it "should describe itself" do
      plan = readme.new_session("spec/fixtures/folder_with_readme", :subject => "Thing").plan
      plan.describe.should ==  <<-eof.gsub(/^ +/,'').strip
        generate file: README.md
      eof
    end

  end
end
