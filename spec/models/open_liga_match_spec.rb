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

  describe "#points_first_half_team*" do
    it "returns goals for first half if match_results is present" do
      o = OpenLigaMatch.new :match_results => {:match_result => [{ :points_team1 => "2", :points_team2 => "1", :result_order_id => "1" },
                                                                 { :points_team1 => "0", :points_team2 => "1", :result_order_id => "2" }]}
      o.points_first_half_team1.should == 0
      o.points_first_half_team2.should == 1
    end

    it "returns nil if there's no result for the first half" do
      o = OpenLigaMatch.new
      o.points_first_half_team1.should be_nil
      o.points_first_half_team2.should be_nil
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
