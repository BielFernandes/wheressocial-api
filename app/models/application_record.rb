class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def liked_by_user?(user)
    likes.exists?(user_id: user.id)
  end
end
