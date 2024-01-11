class PostSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author ,:author_nickname, :post_content, :created_at, :liked, :shares_count ,:comments_count, :likes_count

  def author_id
    object.user.id
  end

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

  def shares_count
    object.shares.count
  end

  def comments_count
    object.comments.count
  end

  def likes_count
    object.likes.count
  end
end
