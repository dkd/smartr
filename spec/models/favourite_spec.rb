require 'spec_helper'

describe Favourite do
  describe "relations" do
    it { 
        should belong_to :user
        should belong_to :question
      }  
  end
end