class SetDefaultValueToReputationOfUser < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :reputation, 0)
  end

  def self.down
  end
end
