class AddVotesCountToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :votes_count, :integer, :default => 0
  end

  def self.down
    remove_column :answers, :votes_count
  end
end
