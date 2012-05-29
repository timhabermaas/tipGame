class RemoveTeamIdFromMatches < ActiveRecord::Migration
  def up
    remove_column :matches, :team_1_id
    remove_column :matches, :team_2_id
  end

  def down
    add_column :matches, :team_1_id, :integer, :null => false, :default => 0
    add_column :matches, :team_2_id, :integer, :null => false, :default => 0
  end
end
