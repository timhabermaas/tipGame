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

  def goal_diff
    goals - goals_against
  end

  def goals
    g1 = home_matches.matches_with_result.where(:round => "Vorrunde").inject(0) { |sum, m| sum + m.goals_team_1 }
    g2 = guest_matches.matches_with_result.where(:round => "Vorrunde").inject(0) { |sum, m| sum + m.goals_team_2 }
    g1 + g2
  end

  def goals_against
    g1 = home_matches.matches_with_result.where(:round => "Vorrunde").inject(0) { |sum, m| sum + m.goals_team_2 }
    g2 = guest_matches.matches_with_result.where(:round => "Vorrunde").inject(0) { |sum, m| sum + m.goals_team_1 }
    g1 + g2
  end
end
