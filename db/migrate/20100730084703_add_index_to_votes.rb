class AddIndexToVotes < ActiveRecord::Migration
  def self.up
    add_index :votes, [:voteable_id, :voteable_type]
  end

  def self.down
    remove_index :votes, [:voteable_id, :voteable_type]
  end
end
