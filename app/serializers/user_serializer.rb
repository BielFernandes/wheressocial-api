class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname,:email, :followers_count, :follows_count, :posts_count, :likes_count

  def followers_count
    object.followers.count
  end

  def follows_count
    object.followeds.count
  end

  def posts_count
    object.posts.count + object.shares.count
  end

  def likes_count
    object.likes.count
  end

end
