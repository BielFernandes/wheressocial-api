class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    def liked_by_user?(user)
        likes.exists?(user_id: user.id)
    end

end
