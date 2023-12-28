class ShareSerializer < ActiveModel::Serializer
  attributes :id, :shared_author, :shared_content, :created_at, :post, :comments

  has_many :comments

  def shared_author
    object.user.name
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

end
