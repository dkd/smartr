require 'spec_helper'

describe Question do
  let(:question) {Factory.create :question}
  
  it { should have_many :votes
       should have_many :comments
       should have_many :answers
       should belong_to :user
       should have_many(:tags).through(:tag_taggings) 
     }
  
  describe "validation" do
    
    describe "of name" do
    
      it "requires presence" do
        question = Factory.build(:question, :name => nil)
        question.should_not be_valid
      end
    
      it "requires uniqueness" do
        duplicate_question =  Factory.build(:question, :name => question.name)
        duplicate_question.should_not be_valid
      end
    
    end
    
    describe "of body" do
    
      it "requires presence" do
        question = Factory.build(:question, :body => nil)
        question.should_not be_valid
      end
    
      it "requires uniqueness" do
        duplicate_question =  Factory.build(:question, :body => question.body)
        duplicate_question.should_not be_valid
      end
    
    end
    
    describe "of tag_list" do
    
      it "requires presence" do
        question = Factory.build(:question, :tag_list => nil)
        question.should_not be_valid
      end
      
      it "should have not more than 8 tags" do
        tags = []
        9.times { tags << Faker::Name.last_name}
        question = Factory.build(:question, :tag_list => tags.join(","))
        question.should_not be_valid
      end
      
      it "should have only downcase tags" do
        
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

