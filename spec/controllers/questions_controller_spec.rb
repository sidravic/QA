require 'spec_helper'

describe QuestionsController do
  render_views

  before(:each) do
    @user = Factory(:user)  
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :user_id => @user.id
      response.should be_success
    end
 
    it "should have the right title" do
      get :new, :user_id => @user.id
      response.should have_selector("title", :content => "Ask Question")
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple",        
      }

      @valid_category_attributes =  {:title => "SometTitle" } 
      
    end

    describe "valid question" do
      it "should create a new question" do        
        controller.stub!(:current_user).and_return(@user)
        count = Question.count
        post :create, :user_id => @user.id, :question => @valid_question_attributes, :category => @valid_category_attributes
        Question.count.should eql(count + 1)
      end
    end

    describe "failure question" do
      it "should prevent the user from posting a new question" do
        controller.stub!(:current_user).and_return(@user)
        count = Question.count
        post :create, :user_id => @user.id, :question => @valid_question_attributes.merge({:title => nil, :description => nil}), :category => @valid_category_attributes.merge({:title => ""})
        Question.count.should eql(count)
        response.should render_template("new")
      end 
    end

  end 
 

  describe "GET 'edit'" do
    before(:each) do
      @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple"
      }

      @question = Question.create(@valid_question_attributes) 
      get :edit, :user_id => @user.id, :id => @question.id
      response.should have_selector("title", :content => "Edit - Ask a Question")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple"
      }
      
      @question = Question.create!(@valid_question_attributes)      
      controller.stub!(:current_user).and_return(@user) 
    end

    it "should update the posted question" do
      put :update, :user_id => @user.id, :id => @question.id,  :question => @valid_question_attributes.merge({:title => "Should I learn Python",:description => "Should I learn Python Should I learn Python"})
      @question.reload
      @question.title.should eql("Should I learn Python")
      @question.description.should eql("Should I learn Python Should I learn Python")
      response.should redirect_to user_question_url(@user.id, @question.id)

    end
  end

  describe "DELETE 'destroy'" do    
    before(:each) do
       @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple"
      }

      controller.stub!(:current_user).and_return(@user)
      @question = Question.create!(@valid_question_attributes)
      @answer = Answer.create!(:content => "The answer is china" )
    end

    describe "succesful deletion" do
      it "should delete a question if it has no answers" do
        count = Question.count
        delete :destroy, :user_id => @user.id, :id => @question.id
        Question.count.should eql(count - 1)
      end
    end
    
    describe "delete failure" do      
        before(:each) do
          @question.answers << @answer
          @question.save(:validate => false)
        end

      it "should not delete a question if it has answers" do
        count = Question.count
        delete :destroy, :user_id => @user.id, :id => @question.id
        Question.count.should eql(count)
      end
    end    
  end
end
