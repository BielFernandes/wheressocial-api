class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    # belongs_to :post
    belongs_to :user

    # validates :content, presence: true

    # validates :user_id, presence: true

    # validates :post_id, presence: true
    
    # validates :content, length: {minimum: 1}
end
