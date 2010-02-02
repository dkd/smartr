require "rubygems"
require 'ruby-growl' if RAILS_ENV == "development"

class Tell
  attr_accessor :g
  def initialize(message)
   g = Growl.new("localhost", "ruby-growl", ["ruby-growl Notification"], ["ruby-growl Notification"], nil) if RAILS_ENV == "development"
   g.notify("ruby-growl Notification", "Reputation", message, 1, true) if RAILS_ENV == "development"
  end
end 

class Reputation
  
  
  def self.set(direction, record, user, owner)
    model = record.constantize.class_name.downcase
    points = Settings.reputation.fetch(model).fetch(direction)
    Tell.new "#{owner.login}, #{direction}: #{record.constantize.class_name}, Point: #{points}"
    if (owner.reputation.nil?)
      owner.reputation = 0
    end
    new_reputation = (owner.reputation + points)<0? 0:(owner.reputation + points)
    owner.update_attributes :reputation => (new_reputation)
  end
  
  def self.penalize(record, user, owner)
    model = record.constantize.class_name.downcase
    penalty = Settings.reputation.fetch(model).fetch("penalty")
    Tell.new "Penalty of #{penalty} points on #{user.login}"
    reputation = user.reputation.nil?? 0 : user.reputation
    new_reputation = (reputation + penalty) <0 ? 0:(reputation + penalty)
    user.update_attributes(:reputation => (new_reputation))
  end
  
  def self.unpenalize(record, user, owner)
    model = record.constantize.class_name.downcase
    penalty = Settings.reputation.fetch(model).fetch("penalty")
    Tell.new "Removed penalty: #{user.login} regained #{penalty.abs} points.)"
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
    question.update_attributes :answer_id => answer.id
    return answer.id
  end
  
  def self.reject_answer(question, answer)
    Tell.new "reject answer from #{question.answer.user.login}"
    
    if question.answer.user!= question.user
      Tell.new "#{question.answer.user.login} loses points"
    end
    question.update_attributes :answer_id => 0
    return 0
  end
  
end