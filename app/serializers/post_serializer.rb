class PostSerializer < ActiveModel::Serializer
  attributes :id, :content

  belongs_to :user
  has_many :comments
end
