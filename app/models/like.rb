class Like < ApplicationRecord
    belongs_to :likeable, polymorphic: true
    belongs_to :user
    belongs_to :post

    validates :content, presence: true

    validates :user_id, presence: true
    
    validates :post_id, presence: true

end
