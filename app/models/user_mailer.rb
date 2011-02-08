class UserMailer < ActionMailer::Base
  
  helper :application
  
  def question_update(question, object)
    
    recipients    question.user.email
    from          "SmartR Notification <do-not-reply@smartr.dkd.de>"
    subject       "New #{object.class.name.downcase} on your question!"
    sent_on       Time.now
    content_type  "text/html"
    body          :question => question, :object => object
  end
    
end