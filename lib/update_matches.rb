class UpdateMatches
  def self.perform
    OpenLigaMatch.all.each do |m|
      match = Match.find_by_match_id m[:match_id]
      if match.nil?
        Match.create!(:match_id => m[:match_id],
                      :team_1_name => m[:name_team1],
                      :team_2_name => m[:name_team2],
                      :finished => m[:match_is_finished],
                      :goals_team_1 => m[:points_team1],
                      :goals_team_2 => m[:points_team2],
                      :starts_at => m[:match_date_time_utc])
      else
        match.update_attributes(:goals_team_1 => 4, :goals_team_2 => 3)
      end
    end
  end
end
