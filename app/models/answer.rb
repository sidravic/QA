class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :content, :presence => true
  
  attr_accessible :content
end
