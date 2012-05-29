require "update_matches"

class OpenLigaMatch; end

class Match; end

describe UpdateMatches do
  let (:response) do
    {
      :match_id => 4,
      :match_results => {
        :match_result => {
          :points_team1 => 4,
          :points_team2 => 3
        }
      }
    }
  end

  context "match doesn't exist" do
    it "adds match to database" do
      OpenLigaMatch.should_receive(:all).and_return [response]
      Match.should_receive(:find_by_match_id).with(4).and_return nil
      Match.should_receive(:create).with(:match_id => 4)
      UpdateMatches.perform
    end
  end

  context "match does exist" do
    let(:match) { double(:update_attributes => true) }

    it "doesn't add match to database when it already exists" do
      OpenLigaMatch.should_receive(:all).and_return [response]
      Match.should_receive(:find_by_match_id).with(4).and_return match
      Match.should_not_receive(:create)
      UpdateMatches.perform
    end

    it "updates the existing match" do
      match.should_receive(:update_attributes).with(hash_including(:goals_team_1 => 4, :goals_team_2 => 3))
      OpenLigaMatch.should_receive(:all).and_return [response]
      Match.should_receive(:find_by_match_id).with(4).and_return match
      UpdateMatches.perform
    end
  end
end
