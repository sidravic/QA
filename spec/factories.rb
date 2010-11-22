Factory.define :user do |user|
  user.name "Siddharth Ravichandran"
  user.email "sid.ravichandran@gmail.com"
  user.password "Test123"
  user.password_confirmation "Test123"
end

Factory.define :profile do |profile|
  profile.descripton "Ruby on Rails developer"
  profile.url "http://errorwatch.wordpress.com"
end

Factory.define :answer do |answer|
  answer.content "This is the house that jack built"  
end

Factory.define :question do |question|
  question.title "What is the capital of China"
  question.description "What is the capital of the Asian Country called China"
  question.association :user

end