class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    def liked_by_user?(user)
        likes.exists?(user_id: user.id)
    end

    validates :content, presence: true

    validates :user_id, presence: true

    validates_associated :comments, :likes
    
    validates :content, length: {minimum: 1}
    

end
