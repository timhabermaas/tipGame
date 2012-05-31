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
end
