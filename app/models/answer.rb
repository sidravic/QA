class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  
  has_many :comments, :as => :commentable
  has_one :inverse_accepted_answer, :class_name => 'Question', :foreign_key => 'accepted_id'

  validates :content, :presence => true
  
  attr_accessible :content
end
