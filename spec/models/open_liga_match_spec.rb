require "spec_helper"

describe OpenLigaMatch do
  describe "#all" do
    it "should return an array of matches" do
      matches = VCR.use_cassette('OpenLigaMatch#all') do
        OpenLigaMatch.all
      end
      matches.class.should == Array
      matches.first[:name_team1].should == "Polen"
    end
  end
end
