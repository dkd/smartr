class CreateEdits < ActiveRecord::Migration
  def self.up
    create_table :edits do |t|
      t.integer :user_id
      t.string :editable_type
      t.integer :editable_id
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :edits
  end
end
