class RemoveOldTables < ActiveRecord::Migration
  def self.up
    drop_table :permissions_user_groups
    drop_table :permissions
    drop_table :open_id_authentication_associations
    drop_table :open_id_authentication_nonces
    drop_table :user_groups_users
    drop_table :user_groups
    remove_column :users, :openid_identifier
  end

  def self.down
  end
end
