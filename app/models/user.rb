class User < ActiveRecord::Base
  acts_as_authentic  
  validates :name, :presence => true
  has_one :profile


  def profile=(params)    
    self.profile.update_attributes(params)    
  end

  
  
end
