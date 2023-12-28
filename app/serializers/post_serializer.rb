class PostSerializer < ActiveModel::Serializer
  attributes :id, :post_author ,:post_content, :liked

  # belongs_to :user
  # has_many :comments
  # has_many :likes
  # has_many :shares

  def post_author
    {
      id: object.user.id,
      name: object.user.name,
      nickname: object.user.nickname,
    }
  end

  def post_content
    object.content
  end

  attribute :liked, if: -> { current_user.present? }

  def liked
    object.liked_by_user?(current_user)
  end
end
