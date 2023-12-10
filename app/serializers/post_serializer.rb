class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :liked_by_current_user

  belongs_to :user
  has_many :comments
  has_many :likes

  attribute :liked_by_current_user, if: -> { current_user.present? }

  def liked_by_current_user
    object.liked_by_user?(current_user)
  end
end
