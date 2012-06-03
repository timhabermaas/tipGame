require "spec_helper"

describe Match do
  describe "#points_for_team_?" do
    it "returns 3 for team 1 and 0 for team 3 if team 1 won" do
      match = Factory.build(:match, :goals_team_1 => 2, :goals_team_2 => 1)
      match.points_for_team_1.should == 3
      match.points_for_team_2.should == 0
    end

    it "returns 1 for both teams when match was a draw" do
      match = Factory.build(:match, :goals_team_1 => 2, :goals_team_2 => 2)
      match.points_for_team_1.should == 1
      match.points_for_team_2.should == 1
    end

    it "returns 0 for team 1 and 3 for team 3 if team 2 won" do
      match = Factory.build(:match, :goals_team_1 => 0, :goals_team_2 => 1)
      match.points_for_team_1.should == 0
      match.points_for_team_2.should == 3
    end
  end
end
