class UserMailer < ActionMailer::Base
  
  def activation(user)
    @user = user    
    @perishable_token = @user.perishable_token
    mail(:to => user.email, :from => "registration@answers.siddharthravichandran.com", :subject => "Activate your account")
  end
end
