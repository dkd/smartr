require "spec_helper"

describe "questions/index.html.erb" do
  include Devise::TestHelpers
  before do
      controller.singleton_class.class_eval do
        protected
          def is_admin?
            false
          end
          helper_method :is_admin?
      end
    end
  it "displays questions list" do
    question = Factory.create :question2
    assign(:questions, (Question.latest.includes([:user,:votes]).paginate :page => params[:page], :per_page => 15))
    render
    rendered.should include(question.name)
  end
  
end