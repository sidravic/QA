require 'spec_helper'

describe PagesController do
 render_views  
  describe "GET 'about'" do 
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get :about
      response.should have_selector("title", :content => "About | easyQA")
    end


  end

  describe "GET 'contact_us'" do
    it "should be successful" do
      get 'contact_us'
      response.should be_success
    end

    it "should have the right title" do
      get :contact_us
      response.should have_selector("title", :content => "Contact | easyQA")

    end

  end

end
