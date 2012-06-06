require "spec_helper"

describe User do
  context "#forgotten_matches" do
    let(:user) { Factory(:user) }
    let!(:match1) { Factory(:match) }
    let!(:match2) { Factory(:match) }
    let!(:match3) { Factory(:match) }

    it "returns all matches starting in less than 24h which the user didn't bet on" do
      Match.stub(:start_in_less_than_24h) { [match1, match2, match3] }
      Timecop.freeze(DateTime.new(2010, 11, 3, 1, 0)) do
        user.tips << Factory.build(:tip, :match => match2)
        user.save!
      end
      user.forgotten_matches.should include(match1)
      user.forgotten_matches.should_not include(match2)
      user.forgotten_matches.should include(match3)
    end
  end
end
