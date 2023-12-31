class ShareSerializer < ActiveModel::Serializer
  attributes :id, :author, :author_nickname, :shared_content, :liked, :created_at, :post, :comments_count, :likes_count,:comments

  has_many :comments

  def author
    object.user.name
  end

  def author_nickname
    object.user.nickname
  end

  def shared_content
    object.content
  end

  def post_content
    object.content
  end

  def post
    {
      id: object.post.id,
      author: object.post.user.name,
      nickname_author: object.post.user.nickname,
      post_content: object.post.content
    }
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
