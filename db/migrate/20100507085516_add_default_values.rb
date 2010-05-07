class AddDefaultValues < ActiveRecord::Migration
  def self.up
    change_column_default(:questions, :views, 0)
    change_column_default(:questions, :votes_count, 0)
    change_column_default(:questions, :answers_count, 0)
    change_column_default(:questions, :send_email, 0)
  end

  def self.down
    
  end
end
