=begin
require 'spec_helper'

describe Question do
  before(:each) do
    @valid_question_attributes = {:title => "SomeTitle",
      :description => "SomeDescription"}
    @valid_category_attributes = {:title => "ValidTitle"}
    @category = Category.create(@valid_category_attributes)
    @new_category =  Category.create!(:title => "New-Test-Category")
  end

  it "should have one error when the category is empty for a question" do
    question = Question.new(@valid_question_attributes)
    question.should_not be_valid    
  end

  it "should not be valid if the title is missing" do
    question = Question.new(@valid_question_attributes.merge({:title => ""}))
    question.categories << @category
      question.should_not be_valid
  end
  it "should not be valid if the description is missing" do
    question = Question.new(@valid_question_attributes.merge({:description => ""}))
    question.categories << @category
    question.should_not be_valid
  end

  it "should add a category for a question" do
    question = Question.new(@valid_question_attributes.merge({:description => ""}))
    3.times do |index|
      question.categories << Category.create(@valid_category_attributes.merge(:title => "category_#{index}"))
    end
    question.save
    question.add_category(@new_category)
    question.categories.include?(@new_category).should eql(true)
  end

  it "should remove deselected categorize for a question" do
    question = Question.new(@valid_question_attributes.merge({:description => ""}))
    3.times do |index|
      question.categories << Category.create(@valid_category_attributes.merge(:title => "category_#{index}"))
    end
    question.add_category(@new_category)
    question.save
    question.remove_category(@new_category)
    question.categories.include?(@new_category).should eql(false)
  end

end
=end