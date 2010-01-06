namespace :smartr do
  
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
  
  
end