class MakeUserColumnsDeviceCompatible < ActiveRecord::Migration
  def self.up
    
    rename_column :users, :crypted_password, :encrypted_password
    rename_column :users, :persistence_token, :authentication_token
    rename_column :users, :login_count, :sign_in_count
    rename_column :users, :current_login_at, :current_sign_in_at
    rename_column :users, :last_login_at, :last_sign_in_at
    
    rename_column :users, :current_login_ip, :current_sign_in_ip
    rename_column :users, :last_login_ip, :last_sign_in_ip
    
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_token, :string
    add_column :users, :remember_created_at, :datetime
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :failed_attempts, :integer
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
  
    
    remove_index :users, :login
    remove_index :users, :persistence_token
    remove_index :users, :last_request_at
    
    add_index :users, :login,                :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    remove_column :table_name, :column_name
    remove_column :users, :locked_at
    remove_column :users, :unlock_token
    remove_column :users, :failed_attempts
    remove_column :users, :confirmation_sent_at
    remove_column :users, :reset_password_token
    remove_column :users, :remember_token
    remove_column :users, :remember_created_at
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    
    rename_column :users, :encrypted_password, :crypted_password
    rename_column :users, :authentication_token, :persistence_token
    rename_column :users, :sign_in_count, :login_count
    rename_column :users, :current_sign_in_at, :current_login_at
    rename_column :users, :last_sign_in_at, :last_login_at
    rename_column :users, :current_sign_in_ip, :current_login_ip
    rename_column :users, :last_sign_in_ip, :last_login_ip
    
    remove_index :users, :email,                :unique => true
    remove_index :users, :reset_password_token, :unique => true
    remove_index :users, :confirmation_token,   :unique => true
    remove_index :users, :unlock_token,         :unique => true
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :last_request_at
    add_index :users, ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
    add_index :users, ["email"], :name => "index_users_on_email", :unique => true
    add_index :users, ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    add_index :users, ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
    
  end
end
