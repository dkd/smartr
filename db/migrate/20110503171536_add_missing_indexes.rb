class AddMissingIndexes < ActiveRecord::Migration
  def self.up

    # These indexes were found by searching for AR::Base finds on your application
    # It is strongly recommanded that you will consult a professional DBA about your infrastucture and implemntation before
    # changing your database in that matter.
    # There is a possibility that some of the indexes offered below is not required and can be removed and not added, if you require
    # further assistance with your rails application, database infrastructure or any other problem, visit:
    #
    # http://www.railsmentors.org
    # http://www.railstutor.org
    # http://guides.rubyonrails.org


    add_index :votes, :user_id
    add_index :favourites, :user_id
    add_index :favourites, :question_id
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :questions, :user_id
    add_index :questions, :answer_id
    add_index :reputation_histories, :answer_id
    add_index :reputation_histories, :vote_id
    add_index :edits, :user_id
    add_index :edits, [:editable_id, :editable_type]
    add_index :answers, :user_id
    add_index :answers, :question_id
    add_index :taggings, [:tagger_id, :tagger_type]
  end

  def self.down
    remove_index :votes, :user_id
    remove_index :favourites, :user_id
    remove_index :favourites, :question_id
    remove_index :comments, :user_id
    remove_index :comments, :column => [:commentable_id, :commentable_type]
    remove_index :questions, :user_id
    remove_index :questions, :answer_id
    remove_index :reputation_histories, :answer_id
    remove_index :reputation_histories, :vote_id
    remove_index :edits, :user_id
    remove_index :edits, :column => [:editable_id, :editable_type]
    remove_index :answers, :user_id
    remove_index :answers, :question_id
    remove_index :taggings, :column => [:tagger_id, :tagger_type]
  end
end