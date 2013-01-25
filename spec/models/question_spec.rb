require 'spec_helper'

describe Question do
  let(:question) {FactoryGirl.create :question2}

  it { should have_many :votes }
  it { should have_many :comments }
  it { should have_many :answers }
  it { should belong_to :user }
  it { should have_many :favourites }
  it { should have_many(:tags).through(:tag_taggings) }

  describe "validation" do

    describe "of name" do

      it "requires presence" do
        question = FactoryGirl.build(:question, :name => nil)
        question.should_not be_valid
      end

      it "requires uniqueness" do
        duplicate_question =  FactoryGirl.build(:question, :name => question.name,  :user => FactoryGirl.create(:user2))
        duplicate_question.should_not be_valid
      end

      describe "of tag_list" do

        it "requires presence" do
          question = FactoryGirl.build(:question, :tag_list => nil)
          question.should_not be_valid
        end

        it "should have not more than 8 tags" do
          question = FactoryGirl.build(:question, :tag_list => "tag1,tag2,tag3,tag4,tag5,tag6,tag7,tag8,tag9")
          question.should_not be_valid
        end

        it "should have only downcase tags" do
          question = FactoryGirl.build(:question, :tag_list => "RUBY,JAVASCRIPT")
          question.should be_valid
          question.tag_list.should == ["ruby","javascript"]
        end

        it "should have only valid tags" do
          question = FactoryGirl.build(:question, :tag_list => "ruby .+,%JAVASCRIPT")
          question.should be_valid
          question.tag_list.should == ["ruby","javascript"]
        end

      end

      describe "body" do

        it "requires presence" do
          question = FactoryGirl.build(:question, :body => nil)
          question.should_not be_valid
        end

        it "requires uniqueness" do
          duplicate_question =  FactoryGirl.build(:question, :body => question.body)
          duplicate_question.should_not be_valid
        end

      end

    end

    describe "methods" do
      describe "answered_by?" do
        let(:question) { FactoryGirl.create(:question2) }

        it "returns true if question has an answer by user" do
          answer = FactoryGirl.create(:answer, :user => FactoryGirl.create(:endless_user), :question => question)
          question.answered_by?(answer.user).should eq(true)
        end

        it "returns false if question has no answers by user" do
          question.answered_by?(FactoryGirl.create(:endless_user)).should eq(false)
        end

      end
    end

  end
end