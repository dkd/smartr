class Reputation
  
  def self.set(direction, record, user, owner)
    model = record.constantize.class_name.downcase
    points = Settings.reputation.fetch(model).fetch(direction)
    if (owner.reputation.nil?)
      owner.reputation = 0
    end
    new_reputation = (owner.reputation + points)<0? 0:(owner.reputation + points)
    owner.update_attributes :reputation => (new_reputation)
  end
  
  def self.penalize(record, user, owner)
    model = record.constantize.class_name.downcase
    penalty = Settings.reputation.fetch(model).fetch("penalty")
    reputation = user.reputation.nil?? 0 : user.reputation
    new_reputation = (reputation + penalty) <0 ? 0:(reputation + penalty)
    user.update_attributes(:reputation => (new_reputation))
  end
  
  def self.unpenalize(record, user, owner)
    model = record.constantize.class_name.downcase
    penalty = Settings.reputation.fetch(model).fetch("penalty")
    reputation = user.reputation.nil?? 0 : user.reputation
    user.update_attributes(:reputation => (reputation + penalty.abs))
  end
  
  def self.toggle_acceptance(question, answer)
    
    if question.answer == answer
      id = reject_answer(question, answer)
    else
      id = accept_answer(question, answer)
    end
    
    return id
  end
  
  def self.accept_answer(question, answer)
   
    if question.answer.present?
      reject_answer(question, answer)
    end
    
    if(question.user != answer.user)
      reputation = answer.user.reputation <= 0?  0 : answer.user.reputation
      new_reputation = reputation + Settings.reputation.answer.accept
      answer.user.attributes = {:reputation => new_reputation}
      answer.user.save(false)
    end
    
    question.attributes = {:answer_id => answer.id}
    question.save(false)
   
    return answer.id
  
  end
  
  def self.reject_answer(question, answer)
    
    points = Settings.reputation.answer.accept
    new_reputation = (question.answer.user.reputation - points) <= 0? 0 : (question.answer.user.reputation - points)
    
    if question.user != question.answer.user
      question.answer.user.attributes = {:reputation => new_reputation}
      question.answer.user.save(false)
    end
    
    question.attributes = {:answer_id => 0}
    question.save(false)
    
    return 0
  
  end
  
end