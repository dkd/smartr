class AddSendEmailToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :send_email, :boolean, :default => false
  end

  def self.down
    remove_column :answers, :send_email
  end
end
