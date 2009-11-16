class String
  
  def correctize_plural(number)
    
    if(number==1)
      self.singularize
    else
      self.pluralize
    end
  end
  
end