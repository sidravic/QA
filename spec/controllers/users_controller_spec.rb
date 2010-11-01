require 'spec_helper'

describe UsersController do
  render_views 
  
  describe "GET 'new'" do
    it "should be successful" do  
      get 'new'
      response.should be_success
    end

    it "should have the correct title" do
      get :new 
      response.should have_selector("title", :content => "easyQA | Register") 
    end    
  end

  describe "POST 'create'" do
    before(:each) do
      @valid_attributes = {:email => "sid.ravichandran@gmail.com",
        :name => "Siddharth Ravichandran",
        :password => "test123",
        :password_confirmation => "test123"
      }
    end
    
    describe "failure" do
      it "should not allow the user to register" do
        count = User.count
        post :create, :user => @valid_attributes.merge({:email => "sas"})
        User.count.should eql(count) 
        response.should render_template("new")
      end
    end

    describe "success" do
      it "should allow the user to register" do
        count = User.count
        post :create, :user => @valid_attributes
        User.count.should eql(count + 1)
        response.should redirect_to user_url(assigns[:user])         
      end

      it "should create a profile for the user" do        
        post :create, :user => @valid_attributes
        assigns[:user].profile.should_not be_nil        
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user) 
    end

    it "should display the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "easyQA | Edit Settings") 
    end

    it "should find the user and display the edit page" do
      User.should_receive(:find).with(@user.id).and_return(@user)
      assigns[:user] = @user
      get :edit, :id => @user.id
      response.should render_template("edit")     
    end

  end

  describe "PUT 'update' " do
    before(:each) do
      @valid_update_attributes = {
        "name" => "Siddharth1",
        "profile" => {
          "description" => "Ruby on Rails Developer",
          "url" => "http://errorwatch.wordpress.com"
        }
      }

      @user = Factory(:user) 
      
      
    end

    it "should update profile and user" do
      controller.stub!(:current_user).and_return(@user)      
      put :update, :id => @user.id, :user => @valid_update_attributes
      @user.name.should eql("Siddharth1")
      @user.profile.description.should eql("Ruby on Rails Developer")
      response.should redirect_to(edit_user_url(@user))     
    end
  end
end