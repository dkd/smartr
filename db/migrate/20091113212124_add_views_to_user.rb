class AddViewsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :views, :integer
  end

  def self.down
    remove_column :users, :views
  end
end
