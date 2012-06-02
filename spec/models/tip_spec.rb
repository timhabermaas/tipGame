require "spec_helper"

describe Tip do
  context "validation" do
    let(:match) { Factory(:match, :starts_at => DateTime.new(2000, 10, 10, 13, 37)) }

    it "is valid if game hasn't started yet" do
      tip = FactoryGirl.build(:tip, :match => match)
      Timecop.freeze(DateTime.new(1999)) do
        tip.should be_valid
      end
    end

    it "isn't valid after game has started" do
      tip = FactoryGirl.build(:tip, :match => match)
      Timecop.freeze(DateTime.new(2001)) do
        tip.should_not be_valid
        tip.errors.messages[:match].should_not be_empty
      end
    end
  end

  context "#points" do
    let(:finished_match) { Factory(:match, :goals_team_1 => 2, :goals_team_2 => 1, :finished => true) }
    let(:running_match) { Factory(:match, :goals_team_1 => 2, :goals_team_2 => 1, :finished => false) }
    let(:unfinished_match) { Factory(:match, :goals_team_1 => nil, :goals_team_2 => nil, :finished => false) }

    it "returns 4 if the tip was 100% accurate" do
      Tip.new(:match => finished_match, :goals_team_1 => 2, :goals_team_2 => 1).points.should == 4
    end

    it "returns 3 if the tip was almost perfect" do
      Tip.new(:match => finished_match, :goals_team_1 => 3, :goals_team_2 => 2).points.should == 3
    end

    it "returns 2 if the player got at least the winner right" do
      Tip.new(:match => finished_match, :goals_team_1 => 4, :goals_team_2 => 0).points.should == 2
    end

    it "returns 0 if the player guessed completely wrong" do
      Tip.new(:match => finished_match, :goals_team_1 => 1, :goals_team_2 => 2).points.should == 0
    end

    it "works for unfinished matches as well" do
      Tip.new(:match => running_match, :goals_team_1 => 2, :goals_team_2 => 1).points.should == 4
    end

    it "returns 0 for matches which don't have a result yet" do
      Tip.new(:match => unfinished_match, :goals_team_1 => 2, :goals_team_2 => 1).points.should == 0
    end
  end
end
