class AddFieldsToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :body_plain, :text
    add_column :questions, :body_html, :text
  end

  def self.down
    remove_column :questions, :body_html
    remove_column :questions, :body_plain
  end
end
