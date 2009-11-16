require 'active_record'

namespace :questions do  desc "Creates the default content" 
  
  desc "Recounting Answers on Question"  
  task :recount_answers => :environment do
    Question.all.each do |question|
      puts "#{question.name} has #{question.answers.length} answers"
      question.answers_count = question.answers.length
      question.save(false)
      end  
  end

end