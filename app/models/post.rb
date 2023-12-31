class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, as: :commentable ,dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :shares, dependent: :destroy

    validates :user_id, presence: true

    validates_associated :comments, :likes
    
    validates :content, length: {minimum: 0}
    

end
