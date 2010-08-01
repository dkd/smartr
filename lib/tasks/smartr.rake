require 'active_record'
require 'sunspot'

namespace :smartr do
  
  namespace :sunspot do
  
    namespace :reindex do
    
      desc "Reindex all models"
      task :all => :environment do
        %w(question answer user).each do |model|
          
          model.classify.constantize.all.each do |record|
            Sunspot.index(record)
            Sunspot.commit
          end
          
        end
      end
    
      desc "Reindex just the user model"
      task :user => :environment do
        User.all.each do |record|
          Sunspot.index(record)
          Sunspot.commit
        end
      end
  end
  end
  
  namespace :tags do
     task :reformat => :environment do
       Tag.all.each do |tag|
         puts tag.name.gsub(/\s+/,"-").downcase
         tag.update_attribute :name, tag.name.gsub(/\s+/,"-").downcase
       end
     end
  end
  
  namespace :questions do
     task :set_permalink => :environment do
       Question.all.each do |question|
         puts question.name
         question.update_attribute :permalink, question.name.to_permalink
       end
     end
  end
  
  namespace :answers do
     task :reformat => :environment do
      
     end
  end
  
  namespace :reputation do  
    desc "Recalaculate Reputation"  
    task :redo => :environment do
    
      User.all.each do |user|
        user.update_attributes :reputation => 0
      end
      
      ReputationHistory.destroy_all

      %w(question answer comment).each do |model|
        puts "Processing #{model.classify.constantize}"
        model.classify.constantize.all.each do |record|
          user = record.user
          record.votes.each do |vote|
            value = 0
            case vote.value
              when 1
                value = Settings.reputation.fetch(vote.voteable_type.downcase).fetch("up")
              when -1
                value = Settings.reputation.fetch(vote.voteable_type.downcase).fetch("down")
            end
            user.update_attributes :reputation => (user.reputation += value)
            
            history = ReputationHistory.new
            history.user = user
            history.vote = vote
            history.points = value
            history.context = "Vote"
            history.created_at = vote.created_at
            history.save
            
            #puts "#{user.login}: #{value} (#{user.reputation})"
          end
        end
      end
      puts "Penalties"
      User.all.each do |user|
        user.votes.each do |vote|
          penalty = Settings.reputation.fetch(vote.voteable_type.downcase).fetch("penalty") 
          if vote.value == -1
            new_reputation = (user.reputation + penalty) < 0 ? 0:(user.reputation + penalty)
            user.update_attributes(:reputation => (new_reputation))
            puts "#{user.login}: #{penalty} (#{user.reputation})"
            
            history = ReputationHistory.new
            history.user = user
            history.vote = vote
            history.points = penalty
            history.context = "Penalty"
            history.created_at = vote.created_at
            history.save
          end
        end
      end
      
      puts "Setting reputation for accepted answers"
      Question.find(:all, :conditions => "answer_id>0").each do |question|
        if(question.user != question.answer.user)
          question.answer.user.update_attributes(:reputation => question.answer.user.reputation += Settings.reputation.answer.accept)
          
          history = ReputationHistory.new
          history.user = question.answer.user
          history.answer = question.answer
          history.points = Settings.reputation.answer.accept
          history.context = "AcceptedAnswer"
          history.created_at = question.updated_at
          history.save
          
          #puts "#{question.answer.user.login}: +#{Settings.reputation.answer.accept} (#{question.answer.user.reputation}) #{question.name}"
        end
      end
      
    end
  
    desc "reset reputation"
    task :reset => :environment do
      User.all.each do |user|
        user.update_attributes :reputation => 0
      end
      User.all.each do |user|
        puts "#{user.login} has now a reputation of #{user.reputation}"
      end
    end
  end
end

def write_reputation_history(user, points, context, vote)
  history = ReputationHistory.new
  history.user = user
  history.reputation = user.reputation
  history.save
end
