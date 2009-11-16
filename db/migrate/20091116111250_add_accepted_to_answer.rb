class AddAcceptedToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :accepted, :boolean
  end

  def self.down
    remove_column :answers, :accepted
  end
end
