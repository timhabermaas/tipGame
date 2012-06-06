class AddRemindedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reminded_at, :datetime
  end
end
