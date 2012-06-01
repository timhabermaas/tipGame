class Tip < ActiveRecord::Base
  include MatchFormat

  belongs_to :user
  belongs_to :match

  validates_presence_of :user_id, :match_id
  validate :match_hasnt_started_yet

  #attr_accessible :goals_team_1, :goals_team_2

  # richtiger Gewinner => 2 Punkt
  # richtige Tordifferenz => 3 Punkte
  # richtiger Tipp => 4 Punkte
  def points
    return 0 unless match.finished?
    return 4 if self.score == match.score
    return 3 if self.goals_diff == match.goals_diff
    return 2 if self.winner == match.winner
    return 0
  end

  def finished?
    !match.finished?
  end

private
  def match_hasnt_started_yet
    errors.add(:match, "can't add") if match.starts_at <= Time.now
  end
end
