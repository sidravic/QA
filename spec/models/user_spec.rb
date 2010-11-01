require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {:name => "Sid",
        :email => "sid.ravichandran@gmail.com",
        :password => "abcabcabc",
        :password_confirmation => "abcabcabc"
    }
  end

 it "should have one error on name" do
    @user = User.new(@valid_attributes.merge({:name => nil}))
    @user.should have(1).errors_on(:name)
 end
end
