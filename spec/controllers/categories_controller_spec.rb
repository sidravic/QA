=begin
require 'spec_helper'

describe CategoriesController do
  before(:each) do
    @category = Category.create(:title => "SomeTitle")
  end

  describe "GET 'index'" do
    it "should list all the categories" do
      get 'index'
      response.should render_template("index")
    end
  end

  describe "GET 'question'" do
    it "should render all the questions for a particular category" do
      get :question, :id => @category.id
      response.should render_template("question")
    end

  end

 

end
=end