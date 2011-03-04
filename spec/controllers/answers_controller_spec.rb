require 'spec_helper'
=begin
describe AnswersController do


  describe "POST 'create'" do
    before(:each) do  
      @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple"        
      }
      @user = Factory(:user)
      @question = Question.new(@valid_question_attributes)
      @question.categories << Category.new(:title => "SomeTitle")
      @question.user_id = @user.id
      @question.save(:validate => false)
      @valid_answer_attributes = { :content => "The answer is china" }

      controller.stub!(:current_user).and_return(@user) 
    end

    describe "with blank answer" do
      it "should not add a new answer to the question " do
        count = @question.answers.size
        get :create, :question_id => @question.id, :answer => @valid_answer_attributes.merge({:content => nil})
        @question.answers.size.should eql(count)        
        
      end
    end

    describe "with a valid complete answer" do
      it "should add a new answer to the question" do
        count = @question.answers.size
        get :create, :question_id => @question.id, :answer => @valid_answer_attributes
        @question.answers.count.should eql(count + 1)
      end
    end
  end

  describe "DESTROY 'delete'" do
    before(:each) do
      @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple"
      }
      @user = Factory(:user)
      @user_2 = User.create!(:name => "Siddha2rth Ravichandran",
        :email => "sid2.ravichandran@gmail.com",
        :password => "abcabcabc",
        :password_confirmation => "abcabcabc")

      @question = Question.new(@valid_question_attributes)
      @question.categories << Category.create(:title => "SomeTitle")
      @answer = Answer.create!(:content => "The answer is china" )
      @answer.user = @user
      @answer.save(:validate => false)
      @question.user_id = @user.id
      @question.answers << @answer
      @question.save!      
    end

    it "should  NOT delete the answer only if the user is NOT the owner of the answer" do
      controller.stub!(:current_user).and_return(@user_2) 
      count = @question.answers.size
      delete :destroy, :id => @answer.id, :question_id => @question.id
      @question.answers.size.should eql(count)
    end

    it "should delete the answer only if the user is the owner of the answer" do
      controller.stub!(:current_user).and_return(@user) 
      count = @question.answers.size
      delete :destroy, :id => @answer.id, :question_id => @question.id
      @question.reload
      @question.answers.size.should eql(count - 1)
    end
    
  end

  describe "PUT 'update' " do
    before(:each) do
      @valid_question_attributes = {
        :title => "What is the capital of China #Geography",
        :description => "What is the capital of the Asian country China",
        :type => "simple"
      }
      @user = Factory(:user)
      @user_2 = User.create!(:name => "Siddha2rth Ravichandran",
        :email => "sid2.ravichandran@gmail.com",
        :password => "abcabcabc",
        :password_confirmation => "abcabcabc")

      @question = Question.new(@valid_question_attributes)
      @answer = Answer.create!(:content => "The answer is china" )
      @answer.user = @user
      @answer.save(:validate => false)
      @question.categories << Category.create(:title => "SomeTitle")
      @question.user_id = @user.id
      @question.answers << @answer
      @question.save(:validate => false)
    end

    it "should update the answer with the new answer" do
      put :update, :id => @answer.id,  :question_id => @question.id, :answer => {:content => "Changed answer is CHina"}
      @answer.reload
      @answer.content.should eql("Changed answer is CHina")
    end
  end

end

=end