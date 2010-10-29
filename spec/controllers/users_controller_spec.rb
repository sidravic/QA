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
  end
end