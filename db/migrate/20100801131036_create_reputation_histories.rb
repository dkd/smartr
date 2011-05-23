class CreateReputationHistories < ActiveRecord::Migration
  def self.up
    create_table :reputation_histories do |t|
      t.integer :user_id
      t.string :context
      t.integer :points, :default => 0
      t.integer :reputation, :default => 0
      t.integer :vote_id, :default => 0
      t.integer :answer_id, :default => 0
      t.timestamps
    end
    add_index :reputation_histories, [:user_id, :context]
  end

  def self.down
    drop_table :reputation_histories
  end
end
