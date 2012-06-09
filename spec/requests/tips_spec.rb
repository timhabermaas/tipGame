require "spec_helper"

describe "/tips", :type => :request do
  let!(:katja) { Factory(:user, :name => "katja") }
  let!(:jannik) { Factory(:user, :name => "jannik") }
  let!(:tim) { Factory(:user, :name => "tim") }
  let!(:old_match1) { Factory(:match_with_result, :starts_at => DateTime.new(1999, 12, 4)) }
  let!(:old_match2) { Factory(:match_with_result, :starts_at => DateTime.new(2001, 3, 2)) }
  let!(:new_match) { Factory(:match_with_result, :starts_at => DateTime.new(2042, 1, 2)) }

  before do
    Timecop.freeze(DateTime.new(1900)) do
      Factory(:tip, :user => katja, :match => old_match1, :goals_team_1 => 3, :goals_team_2 => 1)
      Factory(:tip, :user => katja, :match => old_match2, :goals_team_1 => 1, :goals_team_2 => 3)
      Factory(:tip, :user => jannik, :match => old_match1, :goals_team_1 => 2, :goals_team_2 => 2)
      Factory(:tip, :user => tim, :match => new_match, :goals_team_1 => 3, :goals_team_2 => 3)
    end
  end

  describe "list of tips" do
    it "displays recent tips for all users" do
      visit tips_path
      page.should have_content("katja")
      page.should have_content("tim")
      page.should have_content("jannik")
      page.should have_content("3:1")
      page.should have_content("2:2")
      page.should have_content("1:3")
    end

    it "doesn't display tips for matches which haven't begun yet" do
      visit tips_path
      page.should_not have_content("3:3")
    end
  end
end
