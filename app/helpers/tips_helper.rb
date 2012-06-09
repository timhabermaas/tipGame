module TipsHelper
  def short_match(match)
    match.team_1.name[0..2].upcase + "-" + match.team_2.name[0..2].upcase
  end
end
