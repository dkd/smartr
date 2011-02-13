class AddVotesCountToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :votes_count, :integer, :default => 0
  end

  def self.down
    remove_column :comments, :votes_count
  end
end
