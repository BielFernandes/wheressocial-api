class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_name

  def user_id
    object.user.id
  end

  def user_name
    object.user.name
  end

end
