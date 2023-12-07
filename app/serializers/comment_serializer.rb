class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :user_name

  def user_id
    object.user.id
  end

  def user_name
    object.user.name
  end
end
