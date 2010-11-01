class UserObserver < ActiveRecord::Observer
  def after_create(user)
    user.create_profile
  end
end
