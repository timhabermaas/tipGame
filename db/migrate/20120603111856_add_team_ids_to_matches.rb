class AddTeamIdsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :team_1_id, :integer
    add_column :matches, :team_2_id, :integer
  end
end
