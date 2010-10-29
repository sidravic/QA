class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.string :name
      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.timestamps
    end

    add_index :users,  :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
