class AddVotesCountToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :votes_count, :integer
  end

  def self.down
    remove_column :questions, :votes_count
  end
end
