class AddEmailToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :send_email, :boolean
  end

  def self.down
    remove_column :questions, :send_email
  end
end
