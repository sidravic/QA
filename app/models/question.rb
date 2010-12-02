class Question < ActiveRecord::Base
  require "constants"
  require 'tweeter'
  require 'url_shortner'
  
  attr_accessible :title, :description
  
  validates :title, :presence => true
  validates :description, :presence => true  

  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations
  has_many :comments, :as => :commentable

  
  belongs_to :answer, :foreign_key => 'accepted_id'
  

  default_scope order('created_at DESC')
  scope :simple_questions, where(["questions.type = 'SimpleQuestion'"])
  scope :challenge_questions, where(["questions.type = 'ChallengeQuestion'"])

  after_create :post_as_tweet

  include Constants::CategoryConstant
  include Shortner
  include Rails.application.routes.url_helpers

  def validate    
    self.errors.add(:categories, " Please categorize the question with a valid category ") if self.categories.empty?
  end

  def post_as_tweet
    message = generate_tweet_message
    Tweeter.tweet(message)
  end  

  def categorize(category)
    remove_deselected_category(category) unless category[:title].blank?
    category[:title].split.each_with_index do |_category, index|
      if _category =~ /(\w+)/ && index < MAX_NUMBER_OF_QUESTION_CATEGORIES
          unless existing_category = Category.find_by_title(_category)            
            self.categories.build(:title => sanitize_category(_category).to_s)
          else
            add_category(existing_category) unless self.categories.include?(existing_category)
          end
       end
     end
  end

  def get_categories
    categories_list = ""
    categories.each{|category| categories_list += "#{category.title} " }
    categories_list
  end


  def add_category(existing_category)    
    self.categories << existing_category
  end

  def remove_deselected_category(category)
    to_be_removed = deselected_categories(category)
    to_be_removed.each{|_category|  remove_category(_category) }
  end

  def remove_category(_category)
    self.categories.delete(_category)
  end

private
 def deselected_categories(category)
   self.categories - Category.find_all_by_title(category[:title].split)
 end

 def generate_tweet_message
   title = self.title
   hash_tags = generate_hash_tags
   question_uri = Shortner::Bitly.shorten(get_question_uri)["data"]["url"]
   hash_tag_length = hash_tags.length
   question_uri_length = question_uri.length
   title[0...(140 - (hash_tag_length + 1 + question_uri_length + 3))] + "...#{question_uri}" + " #{hash_tags}"
 end

 def generate_hash_tags
   categories = self.categories.collect{ |category| "##{category.title}" }
   categories.join(" ")
 end

 def sanitize_category(category)
   category.split.join('-')
 end

  def get_question_uri
    url_for(:action => 'show', :controller => 'questions', :id => self.id, :host => HOSTNAME)
  end
  
end
  

