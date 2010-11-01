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