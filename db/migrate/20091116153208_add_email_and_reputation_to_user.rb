class AddEmailAndReputationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :reputation, :integer
  end

  def self.down
    remove_column :users, :reputation
    remove_column :users, :email
  end
end
