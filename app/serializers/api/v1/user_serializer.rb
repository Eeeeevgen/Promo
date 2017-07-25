class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :avatar, :created_at, :updated_at

  has_many :images
  has_many :authorizations

  def avatar
    object.avatar.url
  end
end
