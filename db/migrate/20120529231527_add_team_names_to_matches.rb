class AddTeamNamesToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :team_1_name, :string
    add_column :matches, :team_2_name, :string
  end
end
