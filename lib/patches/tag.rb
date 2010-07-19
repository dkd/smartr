class Tag
  
  #before_save :format_tag_name
    
  def format_tag_name
    self.name = self.name.gsub(/\s+/,"-").downcase
  end
  
end