class UserMailer < ActionMailer::Base

  helper :application
  default :from => Smartr::Settings[:mailer][:from]

  def question_update(question, object)
    recipients    question.user.email
    subject       "New #{object.class.name.downcase} on your question!"
    sent_on       Time.now
    content_type  "text/html"
    @question = question
    @object = object
    mail(:to => question.user.email, :subject => "New #{object.class.name.downcase} on your question!")
  end
    
end