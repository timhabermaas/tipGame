class UpdateMatches
  def self.perform
    OpenLigaMatch.all.each do |m|
      match = Match.find_by_match_id m.match_id

      mapping = {
        :match_id => m.match_id,
        :team_1_name => m.name_team1,
        :team_2_name => m.name_team2,
        :finished => m.match_is_finished,
        :goals_team_1 => m.points_team1,
        :goals_team_2 => m.points_team2,
        :goals_first_half_team_1 => m.points_first_half_team1,
        :goals_first_half_team_2 => m.points_first_half_team2,
        :starts_at => m.match_date_time_utc,
        :round => m.group_name
      }
      if match.nil?
        Match.create!(mapping)
      else
        match.update_attributes(mapping)
      end
    end
  end
end
