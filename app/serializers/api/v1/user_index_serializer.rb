class Api::V1::UserIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :created_at, :updated_at

  def avatar
    object.avatar.url
  end
end
