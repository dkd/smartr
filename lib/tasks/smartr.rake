namespace :smartr do
  
  namespace :tags do
     task :reformat => :environment do
       Tag.all.each do |tag|
         puts tag.name.gsub(/\s+/,"-").downcase
         tag.update_attributes :name => tag.name.gsub(/\s+/,"-").downcase
       end
     end
  end

end