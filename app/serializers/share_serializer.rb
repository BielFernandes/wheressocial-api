class ShareSerializer < ActiveModel::Serializer
  attributes :id
  
  belongs_to :post
  belongs_to :user
  has_many :comments
  has_many :likes
end
