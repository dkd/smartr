class AddBodyPlainToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :body_plain, :text
  end

  def self.down
    remove_column :answers, :body_plain
  end
end
