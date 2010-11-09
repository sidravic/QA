require 'spec_helper'


module QuestionCreator
  def create_question(attributes = {})
    question = (attributes.empty?) ? Factory.build(:question) : Factory.build(:question, attributes)
    question.categories << Category.create(:title => "SomeCategory")
    question.save
    question
  end

  def valid_user_attributes
    {:email => "sid2.ravichandran@gmail.com",
      :name => "Siddhart2h Ravichandran",
      :password => "tes2t123",
      :password_confirmation => "tes2t123"
    }
  end

  def valid_comment_attributes
    {:content => "This is my first comment"}
  end
end

describe CommentsController do
  include QuestionCreator

  

  describe "POST 'create'" do
    before(:each) do
      @valid_comment_attributes = {:content => "This is my first comment"}
      @valid_attributes = {:email => "sid2.ravichandran@gmail.com",
        :name => "Siddhart2h Ravichandran",
        :password => "tes2t123",
        :password_confirmation => "tes2t123"
      }
      @question = create_question
      @user = User.create!(@valid_attributes)
      controller.stub!(:current_user).and_return(@user)
    end
  
    describe "Successful addition for a question" do
      it "should successfully add a new comment" do
        count = @question.comments.size
        post 'create', :question_id => @question.id, :comment => @valid_comment_attributes
        @question.reload
        @question.comments.size.should eql(count + 1)
      end
    end

    describe "Failure in adding a comment for a question" do
      it "should successfully add a new comment" do
        count = @question.comments.size
        post 'create', :question_id => @question.id, :comment => @valid_comment_attributes.merge({:content => ""})
        @question.reload
        @question.comments.size.should eql(count) 
      end
    end
  end

  describe "PUT 'update'" do
    render_views
    before(:each) do       
      @user = User.create(valid_user_attributes)
      @question  = create_question
      @comment = Comment.create(valid_comment_attributes)
      @question.comments << @comment
      @question.user = @user
      @question.save!
    end

    it "should update the comment with the new value" do
      put :update, :id => @comment.id, :question_id => @question.id, :comment => {:content => "This is a new comment"}      
      @comment.reload
      @comment.content.should == "This is a new comment"
    end

    it "should not update the comment if its empty" do
      put :update, :id => @comment.id, :question_id => @question.id, :comment => {:content => ""}
      response.should redirect_to question_url(@question.id)
    end
  end
end
