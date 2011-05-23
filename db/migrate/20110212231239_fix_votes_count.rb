class FixVotesCount < ActiveRecord::Migration
  def self.up

    %w(Answer Question Comment).each do |model|
      model.constantize.all.each do |voteable|
        rating = 0
        voteable.votes.each {|vote| rating += vote.value}
        voteable.update_attributes(:votes_count => rating)
      end
    end


  end

  def self.down
  end
end
