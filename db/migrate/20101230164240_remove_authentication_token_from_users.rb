class RemoveAuthenticationTokenFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :authentication_token
  end

  def self.down
    add_column :users, :authentication_token, :string
  end
end