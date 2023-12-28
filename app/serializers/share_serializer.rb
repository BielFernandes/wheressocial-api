class ShareSerializer < ActiveModel::Serializer
  attributes :id, :content, :author
  
  belongs_to :author, key: :user
  belongs_to :shared_post, key: :post

  def author
    {
      id: object.user.id,
      name: object.user.name,
    }
  end

  def shared_post
    object.post
  end

end
