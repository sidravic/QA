class AddActivatedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :activated_at, :datetime
  end

  def self.down
    remove_column :user, :activated_at
  end
end
