require "active_support/core_ext/object/blank"
require_relative "../../app/models/match_format"

class DummyMatch
  attr_accessor :goals_team_1, :goals_team_2

  def initialize(goals_1 = nil, goals_2 = nil)
    @goals_team_1, @goals_team_2 = goals_1, goals_2
  end

  include MatchFormat
end

describe MatchFormat do
  context "#score" do
    it "returns '2:1' for finished match" do
      match = DummyMatch.new(2, 1)
      match.score.should == "2:1"
    end

    it "returns '-:-' for unfinished match" do
      DummyMatch.new.score.should == "-:-"
    end
  end

  context "#score=" do
    it "sets goals to 2 and 3 respectively for a score of '2:3'" do
      match = DummyMatch.new
      match.score = "2:3"
      match.goals_team_1.should == 2
      match.goals_team_2.should == 3
    end

    it "sets goals to nil for invalid score" do
      match = DummyMatch.new(3, 4)
      match.score = "-:3"
      match.goals_team_1.should be_nil
      match.goals_team_2.should be_nil
    end
  end
end
