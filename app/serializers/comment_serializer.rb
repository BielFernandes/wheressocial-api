class CommentSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :content, :created_at

  def nickname
    object.user.nickname
  end

end
