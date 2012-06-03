class Match < ActiveRecord::Base
  include MatchFormat

  GROUPS = ("A".."D").map { |c| "Gruppe #{c}" }
  ROUNDS = ['Vorrunde', 'Achtelfinale', 'Viertelfinale', 'Halbfinale', 'Spiel um Platz Drei','Finale']

  has_many :tips, :dependent => :delete_all
  has_one :team_1, :class_name => "Team"
  has_one :team_2, :class_name => "Team"

  validates_presence_of :starts_at
  validates_inclusion_of :group, :in => GROUPS, :allow_blank => true
  validates_uniqueness_of :match_id

  before_save :build_team_objects

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
  scope :preliminary, where(:round => "Vorrunde")
  scope :final, where("round <> 'Vorrunde'")

  def finished_goals_team_1
    goals_team_1 ? goals_team_1 : 0
  end

  def finished_goals_team_2
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

  def points_for_team_1
    return 0 if invalid_result?
    if goals_team_1 > goals_team_2
      3
    elsif goals_team_1 < goals_team_2
      0
    else
      1
    end
  end

  def points_for_team_2
    return 0 if invalid_result?
    if goals_team_2 > goals_team_1
      3
    elsif goals_team_2 < goals_team_1
      0
    else
      1
    end
  end

  def running?
    Time.now > self.starts_at and not self.finished
  end

private
  def build_team_objects
    self.team_1 = Team.find_by_name(team_1_name) || Team.new(:name => team_1_name)
    self.team_2 = Team.find_by_name(team_2_name) || Team.new(:name => team_2_name)
    self.team_1.group = group
    self.team_2.group = group
  end
end
