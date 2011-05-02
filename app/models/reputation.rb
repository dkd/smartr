class Reputation

  def self.set(direction, record, user, owner)

    model = record.downcase.to_sym
    points = Smartr::Settings[:reputation][model][direction.to_sym]
    if (owner.reputation.nil?)
      owner.reputation = 0
    end
    new_reputation = (owner.reputation + points) < 0? 0:(owner.reputation + points)
    owner.reputation = new_reputation
    owner.save(:validate => false)
  end

  def self.penalize(record, user, owner)
    model = record.downcase.to_sym
    penalty = Smartr::Settings[:reputation][model][:penalty]
    reputation = user.reputation.nil?? 0 : user.reputation
    new_reputation = (reputation + penalty) < 0 ? 0 : (reputation + penalty)
    user.reputation = new_reputation
    user.save(:validate => false)
  end

  def self.unpenalize(record, user, owner)
    model = record.downcase.to_sym
    penalty = Smartr::Settings[:reputation][model][:penalty]
    reputation = user.reputation.nil?? 0 : user.reputation
    user.reputation = reputation + penalty.abs
    user.save(:validate => false)
  end

  def self.toggle_acceptance(question, answer)
    if question.accepted_answer == answer
      id = reject_answer(question, answer)
    else
      id = accept_answer(question, answer)
    end
  end

  def self.accept_answer(question, answer)
    answer_user = answer.user

    if question.accepted_answer.present?
      reject_answer(question, answer)
    end

    if(question.user != answer_user)
      reputation = answer_user.reputation <= 0?  0 : answer_user.reputation
      new_reputation = reputation + Smartr::Settings[:reputation][:answer][:accept]
      answer_user.reputation = new_reputation
      answer_user.save(:validate => false)
    end

    question.attributes = { :answer_id => answer.id }
    question.save(:validate => false)
  end

  def self.reject_answer(question, answer)
    points = Smartr::Settings[:reputation][:answer][:accept]
    new_reputation = (question.accepted_answer.user.reputation - points) <= 0? 0 : (question.accepted_answer.user.reputation - points)

    if question.user != question.accepted_answer.user
      question.accepted_answer.user.reputation = new_reputation
      question.accepted_answer.user.save(:validate => false)
    end

    question.attributes = { :answer_id => 0 }
    question.save(:validate => false)
  end

end