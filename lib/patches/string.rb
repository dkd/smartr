require "unicode"

class String
  
  def correctize_plural(number)
    
    if(number==1)
      self.singularize
    else
      self.pluralize
    end
  end

   def to_permalink
    str = Unicode.normalize_KD(self).gsub(/[^\x00-\x7F]/n,'')
    str = str.gsub(/\W+/, '-').gsub(/^-+/,'').gsub(/-+$/,'').downcase
  end
  
end