class Integer
  def humanize
    if self > 999
      "#{self.to_s.first}k"
    else
      self
    end
  end
end