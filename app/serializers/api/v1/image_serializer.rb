class Api::V1::ImageSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :image, :likes_count

  def image
    object.image.url
  end
end
