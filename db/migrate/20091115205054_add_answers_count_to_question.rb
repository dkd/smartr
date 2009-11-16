class AddAnswersCountToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :answers_count, :integer
  end

  def self.down
    remove_column :questions, :answers_count
  end
end
