class AddReceivedEmailAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :received_email_at, :datetime
  end
end
