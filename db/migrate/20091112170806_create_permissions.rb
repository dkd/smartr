class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :name

      t.timestamps
    end

		create_table :permissions_user_groups, :id => false do |t|
      t.integer :permission_id
      t.integer :user_group_id
    end
  end

  def self.down
		drop_table :permissions_user_groups
    drop_table :permissions
  end
end
