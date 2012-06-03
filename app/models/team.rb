class Team < ActiveRecord::Base
  TEAM_GROUPS = %w[A B C D E F G H unklar]

  has_many :home_matches, :class_name => "Match", :foreign_key => :team_1_id
  has_many :guest_matches, :class_name => "Match", :foreign_key => :team_2_id

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.team_groups
    TEAM_GROUPS
  end

  def self.team_names
    Team.all.collect do |team|
      [team.name, team.id]
    end
  end

  def self.groups
    TEAM_GROUPS
  end

  def points
    p1 = home_matches.where(:round => "Vorrunde").inject(0) { |sum, m| sum + m.points_for_team_1 }
    p2 = guest_matches.where(:round => "Vorrunde").inject(0) { |sum, m| sum + m.points_for_team_2 }
    p1 + p2
  end

  def goals_self_and_opponent
    diff = Match.where(:team_1_id => self.id).inject([0,0]){ |sum, match| [sum.first + match.finished_goals_team_1, sum.last + match.finished_goals_team_2] }
    Match.where(:team_2_id => self.id).inject(diff){ |sum, match| [sum.first + match.finished_goals_team_2, sum.last + match.finished_goals_team_1] }
  end

  def goal_diff
    goals_self_and_opponent.first - goals_self_and_opponent.last
  end

  def goals
    goals_self_and_opponent.first
  end

end
