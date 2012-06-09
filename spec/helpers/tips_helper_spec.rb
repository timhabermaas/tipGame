require_relative "../../app/helpers/tips_helper"

describe TipsHelper do
  include TipsHelper

  let(:team_1) { stub(:team, :name => "Griechenland") }
  let(:team_2) { stub(:team, :name => "Russland") }

  it "#short_match" do
    match = stub(:match, :team_1 => team_1, :team_2 => team_2)
    short_match(match).should == "GRI-RUS"
  end
end
