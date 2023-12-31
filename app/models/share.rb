class Share < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :comments, as: :commentable ,dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
