require "spec_helper"

describe OpenLigaMatch do
  describe "#points_team1" do
    it "returns 4 if given '4'" do
      o = OpenLigaMatch.new :points_team1 => "4", :points_team2 => "3"
      o.points_team1.should == 4
      o.points_team2.should == 3
    end

    it "returns nil if goals_team1 is negative or isn't set" do
      o = OpenLigaMatch.new :points_team1 => "-1"
      o.points_team1.should be_nil
      o.points_team2.should be_nil
    end
  end

  describe ".all" do
    it "should return an array of matches" do
      matches = VCR.use_cassette('OpenLigaMatch#all') do
        OpenLigaMatch.all
      end
      matches.class.should == Array
      matches.first.name_team1.should == "Polen"
    end
  end
end
