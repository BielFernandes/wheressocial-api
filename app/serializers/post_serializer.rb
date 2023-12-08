class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :liked

  belongs_to :user
  has_many :comments
  has_many :likes
end
