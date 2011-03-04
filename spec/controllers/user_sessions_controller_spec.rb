=begin
require 'spec_helper'

describe UserSessionsController do
  render_views  

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "easyQA | Sign In")
    end
  end

  describe "GET 'create'" do
    before(:each) do
        valid_user_attributes = {:email => "sid.ravichandran@gmail.com", :password => "test123", :password_confirmation => "test123"}
        @user = Factory.create(:user, valid_user_attributes)
        @valid_attributes = {:email => "sid.ravichandran@gmail.com", :password => "test123"}
        
        
    end
      
    it "should be successful" do
      get 'create'
      response.should be_success
    end

    describe "login failure" do
      it "should display the login again on failure" do
        post :create, :user_session => @valid_attributes.merge({:email => ""})
        response.should render_template("new")
      end      
    end

    describe "login success" do
      it "should login the user when entering the correct credentials" do        
        assigns[:current_user] = @user      
        controller.stub!(:current_user).and_return(@user)
        post :create, :user_session => @valid_attributes        
        response.should redirect_to user_url(@user)        
      end
    end
  end

  describe "DELETE 'destroy'" do    
    

    it "should log the user out" do      
    end

  end

end
=end