class Like < ApplicationRecord
    belongs_to :likeable, polymorphic: true
    belongs_to :post
    belongs_to :user
end
