require "spec_helper"

describe Team do
  before do
    Factory(:match, :round => "Vorrunde", :team_1_name => "Griechenland", :team_2_name => "Schweden", :goals_team_1 => 2, :goals_team_2 => 3)
    Factory(:match, :round => "Vorrunde", :team_1_name => "Deutschland", :team_2_name => "Spanien", :goals_team_1 => 1, :goals_team_2 => 1)
    Factory(:match, :round => "Vorrunde", :team_1_name => "Spanien", :team_2_name => "Griechenland", :goals_team_1 => 3, :goals_team_2 => 0)
    Factory(:match, :round => "Finale", :team_1_name => "Spanien", :team_2_name => "Griechenland", :goals_team_1 => 3, :goals_team_2 => 0)
  end

  describe "#points" do
    it "calculates points properly" do
      Team.find_by_name("Schweden").points.should == 3
      Team.find_by_name("Deutschland").points.should == 1
      Team.find_by_name("Griechenland").points.should == 0
      Team.find_by_name("Spanien").points.should == 4
    end
  end

  describe "#goals" do
    it "returns 4 for 'Spanien'" do
      Team.find_by_name("Spanien").goals.should == 4
    end

    it "returns 2 for 'Griechenland'" do
      Team.find_by_name("Griechenland").goals.should == 2
    end
  end
end
