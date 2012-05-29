class Match < ActiveRecord::Base
  require 'match_format'
  include MatchFormat

  @@matches_updated = false

  validates_presence_of :starts_at

  scope :next_matches, lambda {
    order('matches.starts_at ASC').
    where("starts_at > ?", Time.now).
    limit(3)
  }

  scope :last_matches, lambda {
    order('matches.starts_at DESC').
    where("starts_at < ?", Time.now)
  }

  scope :matches_without_result, lambda {
    where("matches.goals_team_1 IS NULL AND matches.goals_team_2 IS NULL")
  }

  scope :not_finished_matches, lambda {
    where(:finished => false)
  }
  def self.round_options
    ['Vorrunde', 'Achtelfinale', 'Viertelfinale', 'Halbfinale', 'Spiel um Platz Drei','Finale']
  end

  def finished?
    has_goals?
  end

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

  def group
    "Gruppe A"
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

  def self.delete_goals_last_matches(number)
    for match in Match.last_matches.limit(number) do
      match.goals_team_1 = nil
      match.goals_team_2 = nil
      match.goals_first_half_team_1 = nil
      match.goals_first_half_team_2 = nil
      match.save
    end
  end

  def running?
    Time.now > self.starts_at and not self.finished
  end

  def self.matches_by_group(group)
    Match.joins(:team_1).where("teams.group" => group)
  end

  def self.all_first_round_matches_by_group
    groups = Hash.new
    Team.team_groups.each do |group|
      groups[group] = matches_by_group(group) #groups << :group => (matches_by_group(group))
    end
    groups
  end

  def self.all_matches_by_round
    matches = Hash.new
    round_options.each do |round|
      matches[round] = Match.where(:round => round)
    end
    matches['Vorrunde'] = all_first_round_matches_by_group
    matches
  end
end
