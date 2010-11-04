class User < ActiveRecord::Base
  acts_as_authentic  
  validates :name, :presence => true
  has_one :profile
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  
  def profile=(params)    
    self.profile.update_attributes(params)    
  end

  
  
end
