class RemoveTypeFromMatches < ActiveRecord::Migration
  def up
    remove_column :matches, :type
  end

  def down
    add_column :matches, :type, :string, :default => 'Preliminary', :null => false
  end
end
