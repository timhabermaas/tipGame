require "update_matches"

class OpenLigaMatch; end

describe UpdateMatches do
  let(:match_class) { stub(:match_class) }
  before { UpdateMatches.const_set(:Match, match_class) }
  after { UpdateMatches.send(:remove_const, :Match) }

  let (:response) do
    {
      :match_id => 4,
      :points_team1 => 4,
      :points_team2 => 3,
      :match_date_time_utc => "2010-08-21T18:43:28.94",
      :name_team1 => "Deutschland",
      :name_team2 => "Frankreich",
      :group_name => "Achtelfinale",
      :match_results => [{:result_order_id => 1, :points_team1 => 4, :points_team2 => 3},
                         {:result_order_id => 2, :points_team1 => 2, :points_team2 => 1}]
    }
  end

  context "match doesn't exist" do
    it "adds match to database" do
      OpenLigaMatch.should_receive(:all).and_return [response]
      match_class.should_receive(:find_by_match_id).with(4).and_return nil
      match_class.should_receive(:create!).with(hash_including(:match_id => 4, :team_1_name => "Deutschland", :round => "Achtelfinale", :goals_first_half_team_2 => 1))
      UpdateMatches.perform
    end
  end

  context "match does exist" do
    let(:match) { double(:update_attributes => true) }

    it "doesn't add match to database when it already exists" do
      OpenLigaMatch.should_receive(:all).and_return [response]
      match_class.should_receive(:find_by_match_id).with(4).and_return match
      match_class.should_not_receive(:create!)
      UpdateMatches.perform
    end

    it "updates the existing match" do
      match.should_receive(:update_attributes).with(hash_including(:goals_team_1 => 4, :goals_team_2 => 3, :round => "Achtelfinale", :goals_first_half_team_1 => 2))
      OpenLigaMatch.should_receive(:all).and_return [response]
      match_class.should_receive(:find_by_match_id).with(4).and_return match
      UpdateMatches.perform
    end

    context "isn't finished and has no match results" do
      before { response.delete(:match_results) }

      it "doesn't crash" do
        match.should_receive(:update_attributes).with(hash_including(:goals_team_1 => 4, :goals_team_2 => 3, :round => "Achtelfinale", :goals_first_half_team_1 => nil))
        OpenLigaMatch.should_receive(:all).and_return [response]
        match_class.should_receive(:find_by_match_id).with(4).and_return match
        UpdateMatches.perform
      end
    end
  end
end
