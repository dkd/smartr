require 'spec_helper'

describe Question do
  let(:question) {Factory.create :question2}
  
  it { should have_many :votes }
  it { should have_many :comments }
  it { should have_many :answers }
  it { should belong_to :user }
  it { should have_many :favourites }
  it { should have_many(:tags).through(:tag_taggings) }

  describe "validation" do
    
    describe "of name" do

      it "requires presence" do
        question = Factory.build(:question, :name => nil)
        question.should_not be_valid
      end

      it "requires uniqueness" do
        duplicate_question =  Factory.build(:question, :name => question.name,  :user => Factory(:user2))
        duplicate_question.should_not be_valid
      end

    end

    describe "of body" do

      it "requires presence" do
        question = Factory.build(:question, :body => nil)
        question.should_not be_valid
      end

      it "requires uniqueness" do
        duplicate_question =  Factory.build(:question2, :body => question.body, :user => Factory(:user2))
        duplicate_question.should_not be_valid
      end

    end
    
    describe "of tag_list" do

      it "requires presence" do
        question = Factory.build(:question, :tag_list => nil)
        question.should_not be_valid
      end

      it "should have not more than 8 tags" do
        question = Factory.build(:question, :tag_list => "tag1,tag2,tag3,tag4,tag5,tag6,tag7,tag8,tag9")
        question.should_not be_valid
      end

      it "should have only downcase tags" do
        question = Factory.build(:question, :tag_list => "RUBY,JAVASCRIPT")
        question.should be_valid
        question.tag_list.should == ["ruby","javascript"]
      end

      it "should have only valid tags" do
        question = Factory.build(:question, :tag_list => "ruby .+,%JAVASCRIPT")
        question.should be_valid
        question.tag_list.should == ["ruby","javascript"]
      end

    end

    describe "body" do

      it "requires presence" do
        question = Factory.build(:question, :body => nil)
        question.should_not be_valid
      end

      it "requires uniqueness" do
        duplicate_question =  Factory.build(:question, :body => question.body)
        duplicate_question.should_not be_valid
      end

    end

  end

end
