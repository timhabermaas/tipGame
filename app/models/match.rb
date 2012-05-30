class Match < ActiveRecord::Base
  include MatchFormat

  GROUPS = ("A".."D").map { |c| "Gruppe #{c}" }
  ROUNDS = ['Vorrunde', 'Achtelfinale', 'Viertelfinale', 'Halbfinale', 'Spiel um Platz Drei','Finale']

  has_many :tips, :dependent => :delete_all

  validates_presence_of :starts_at
  validates_inclusion_of :group, :in => GROUPS, :allow_nil => true
  validates_uniqueness_of :match_id

  scope :next_matches, lambda {
    order('matches.starts_at ASC').
    where("starts_at > ?", Time.now).
    limit(3)
  }

  scope :last_matches, lambda {
    order('matches.starts_at DESC').
    where("starts_at < ?", Time.now)
  }

  scope :matches_without_result, where("matches.goals_team_1 IS NULL AND matches.goals_team_2 IS NULL")

  scope :not_finished_matches, where(:finished => false)

  def finished_goals_team_1
    p "1: --  #{team_1.name} : #{team_2.name}"
    p "goals: --- #{goals_team_1 ? goals_team_1 : 0}"
    goals_team_1 ? goals_team_1 : 0
  end

  def finished_goals_team_2
    p "2: --  #{team_1.name} : #{team_2.name}"
    p "goals: --- #{goals_team_2 ? goals_team_2 : 0}"
    goals_team_2 ? goals_team_2 : 0
  end

  def points(team)
    if not finished?
      0
    elsif (team_1_id == team.id and winner == 1 ) or (team_2_id == team.id and winner == 2)
      3
    elsif winner == 0
      1
    else
      0
    end
  end

  def running?
    Time.now > self.starts_at and not self.finished
  end
end
