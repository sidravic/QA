class Question < ActiveRecord::Base
  
  attr_accessible :title, :description
  
  validates :title, :presence => true
  validates :description, :presence => true  

  belongs_to :user
  has_many :answers, :dependent => :destroy

  default_scope order('created_at DESC')
  scope :simple_questions, where(["questions.type = 'SimpleQuestion'"])
  scope :challenge_questions, where(["questions.type = 'ChallengeQuestion'"])
end
