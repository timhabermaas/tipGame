require "spec_helper"

describe Match do
  describe ".start_in_less_than_24h" do
    let!(:match1) { Factory(:match, :starts_at => DateTime.new(2010, 10, 2, 10, 0)) }
    let!(:match2) { Factory(:match, :starts_at => DateTime.new(2010, 11, 2, 14, 0)) }
    let!(:match3) { Factory(:match, :starts_at => DateTime.new(2010, 11, 2, 18, 0)) }

    it "returns matches which start in less than 24h" do
      Timecop.freeze(DateTime.new(2010, 11, 1, 16, 0)) do
        Match.start_in_less_than_24h.should_not include(match1)
        Match.start_in_less_than_24h.should include(match2)
        Match.start_in_less_than_24h.should_not include(match3)
      end
    end
  end

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

  describe "before_save" do
    let(:match1) { Factory.build(:match, :team_1_name => "Griechenland", :team_2_name => "Schweden", :goals_team_1 => 2, :goals_team_2 => 3, :group => "Gruppe A")}
    let(:match2) { Factory.build(:match, :team_1_name => "Deutschland", :team_2_name => "Spanien", :goals_team_1 => 1, :goals_team_2 => 1)}
    let(:match3) { Factory.build(:match, :team_1_name => "Spanien", :team_2_name => "Griechenland", :goals_team_1 => 3, :goals_team_2 => 0)}

    it "creates teams and sets associations to them" do
      match1.save!
      match2.save!
      match3.save!
      teams = Team.all.map(&:name)
      teams.should have(4).items
      teams.should include("Griechenland")
      teams.should include("Deutschland")
      teams.should include("Spanien")
      teams.should include("Schweden")
      match1.reload.team_1.name.should == "Griechenland"
    end

    it "adds group to team if it's present" do
      match3.save!
      Team.find_by_name("Griechenland").group.should == nil
      match1.save!
      Team.find_by_name("Griechenland").group.should == "Gruppe A"
    end
  end
end
