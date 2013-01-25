require "spec_helper"

describe UserMailer do 
  context "Comment:" do
    describe "a comment on a question has been posted" do
      it "and triggers an info mail to the owner of the question" do
        comment = FactoryGirl.create(:comment, 
                                  :commentable => FactoryGirl.create(:question2, :send_email => true),
                                  :body => Faker::Lorem.sentence(6),
                                  :user => FactoryGirl.create(:endless_user)
                                  )
        email = ActionMailer::Base.deliveries.first
        email.subject.should == "New #{comment.class.name.downcase} on your question!"
      end
    end
  end
end
