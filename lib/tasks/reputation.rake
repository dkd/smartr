require 'active_record'

namespace :reputation do  
  desc "Recalaculate Reputation"  
  task :redo => :environment do
    
    User.all.each do |user|
      user.update_attributes :reputation => 0
    end
    
    User.all.each do |user|
      user.votes.each do |vote|
        penalty = Settings.reputation.fetch(vote.voteable_type.downcase).fetch("penalty") 
        puts "Penalty of #{penalty} points on #{user.login}" if vote.value == -1
        user.update_attributes(:reputation => (user.reputation += penalty)) 
      end
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
          puts "#{user.login}: #{value}"
          user.update_attributes :reputation => (user.reputation += value)
        end
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

