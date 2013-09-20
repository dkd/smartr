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
end