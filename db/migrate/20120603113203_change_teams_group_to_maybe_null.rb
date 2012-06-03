class ChangeTeamsGroupToMaybeNull < ActiveRecord::Migration
  def up
    change_column :teams, :group, :string, :null => true, :default => nil
  end

  def down
    change_column :teams, :group, :string, :null => false, :default => "A"
  end
end
