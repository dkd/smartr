class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :voteable_type
      t.integer :voteable_id
      t.integer :user_id
      t.integer :value, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
