class PostSerializer < ActiveModel::Serializer
  attributes :id, :author ,:author_nickname, :post_content, :created_at, :liked, :comments_count, :likes_count, :comments

  has_many :comments

  def author
    object.user.name
  end

  def author_nickname
    object.user.nickname
  end

  def post_content
    object.content
  end

  attribute :liked, if: -> { current_user.present? }

  def liked
    object.liked_by_user?(current_user)
  end

  def comments_count
    object.comments.count
  end

  def likes_count
    object.likes.count
  end
end
