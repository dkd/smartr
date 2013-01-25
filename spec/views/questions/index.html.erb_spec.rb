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
    question = FactoryGirl.create :question2
    assign(:questions, (Question.latest.includes([:user,:votes]).page(params[:page])))
    render
    rendered.should include(question.name)
  end
  
end