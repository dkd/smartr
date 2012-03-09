class UserMailer < ActionMailer::Base

  helper :application
  default :from => Smartr::Settings[:mailer][:from]

  def question_update(question, object)

    @question = question
    @object = object
    mail :to => question.user.email,
         :subject => "New #{object.class.name.downcase} on your question!",
         :content_type => "text/html"
  end

end