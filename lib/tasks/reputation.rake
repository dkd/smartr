require 'active_record'

namespace :smartr do
  namespace :reputation do  
    desc "Recalaculate Reputation"  
    task :redo => :environment do
    
      User.all.each do |user|
        user.update_attributes :reputation => 0
      end
    
      
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
            puts "#{user.login}: #{value} (#{user.reputation})"
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
          end
        end
      end
      
      puts "Setting reputation for accepted answers"
      Question.find(:all, :conditions => "answer_id>0").each do |question|
        
        if(question.user != question.answer.user)
          
          question.answer.user.update_attributes(:reputation => question.answer.user.reputation += Settings.reputation.answer.accept)
          puts "#{question.answer.user.login}: +#{Settings.reputation.answer.accept} (#{question.answer.user.reputation})"
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

