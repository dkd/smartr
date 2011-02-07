class UserMailer < ActionMailer::Base
  default :from => Smartr::Settings[:mailer][:from]
  
  def question_update(question, object)
  end
end
