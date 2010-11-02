class Question < ActiveRecord::Base
  
  attr_accessible :title, :description
  
  validates :title, :presence => true
  validates :description, :presence => true  

  belongs_to :user 
  
  scope :simple_questions, :conditions => ["questions.type = 'SimpleQuestion'"]
  scope :challenge_questions, :conditions => ["questions.type = 'ChallengeQuestion'"]
end
