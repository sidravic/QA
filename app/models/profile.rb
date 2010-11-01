class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy

  validates :description, :length => { :maximum => 500 }
end
