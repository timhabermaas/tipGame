class UpdateMatches
  def self.perform
    OpenLigaMatch.all.each do |m|
      match = Match.find_by_match_id m[:match_id]
      if match.nil?
        Match.create(:match_id => 4)
      else
        match.update_attributes(:goals_team_1 => 4, :goals_team_2 => 3, :finished => true)
      end
    end
  end
end
