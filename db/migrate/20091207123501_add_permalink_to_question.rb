class AddPermalinkToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :permalink, :string
  end

  def self.down
    remove_column :questions, :permalink
  end
end
