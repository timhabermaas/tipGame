class AddGroupToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :group, :string
  end
end
