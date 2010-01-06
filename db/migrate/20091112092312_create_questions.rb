class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :name
      t.text :body
      t.integer :user_id
      t.integer :views

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
